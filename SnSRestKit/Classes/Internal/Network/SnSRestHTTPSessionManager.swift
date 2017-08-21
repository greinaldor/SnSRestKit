//
//  SnSRestServer.swift
//  Pods
//
//  Created by Adrien Greiner on 02/05/17.
//
//

import Foundation
import BoltsSwift
import Alamofire

public protocol SnSRestRequestServing {
    func configureServer()
    func sessionConfiguration() -> URLSessionConfiguration
}

open class SnSRestHTTPSessionManager: SnSRestModule, SnSRestRequestServing, SnSRestRequestRunning {
    
    private var operationQueue = OperationQueue()
    
    private var sessionManager: SessionManager?
    
    override func loadModule() {
        self.configureServer()
    }
    
    override func unloadModule() {
        
    }
    
    // MARK: - SnSRestRequestRunning -
    
    public func runRequestAsync(_ request: SnSRestRequest, _ withOptions: SnSRestRequestRunningOptions) -> SnSRestTask {
        return self.taskFromModuleExecutor(closure: { () -> SnSRestTask in
            // Return cancelledTask if request has been cancelled before execution
            if request.isCancelled {
                return Task.cancelledTask()
            }
            // Perform the request
            return self.perform(request: request)
        })
    }
    
    // MARK: - SnSRestRequestServing -
    
    open func sessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.background(withIdentifier: "com.snsrest.core.server.operationQueue")
        sessionConfiguration.allowsCellularAccess = true
        sessionConfiguration.networkServiceType = .background
        sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfiguration.timeoutIntervalForRequest = 60
        sessionConfiguration.timeoutIntervalForResource = 120
        return sessionConfiguration
    }
    
    open func configureServer() {
        // Configure serve operation queue
        self.operationQueue.maxConcurrentOperationCount = 120
        self.operationQueue.name = "com.snsrest.core.server.operationQueue"
        self.operationQueue.qualityOfService = .background
        
        // Get the session configuration
        let configuration = self.sessionConfiguration()
        self.sessionManager = SessionManager(configuration: configuration)
        self.sessionManager?.startRequestsImmediately = false
    }
    
    // MARK: - Private -
    
    public func perform(request: SnSRestRequest) -> SnSRestTask {
        return self.taskFromModuleExecutor(closure: { () -> SnSRestTask in
            
            guard let sessionManager = self.sessionManager else {
                let error = SnSError.internalError
                let taskResult = SnSRestTaskResult(result: nil, error: error)
                return Task.init(taskResult)
            }
            
            let completionSource = TaskCompletionSource<SnSRestTaskResult>()
            let successClosure: HTTPSessionOperationSuccessClosure = { (response, responseData) -> Void in
                let result = SnSRestRequestResponse(request,
                                                    data: response?.data,
                                                    statusCode: response?.response?.statusCode,
                                                    headers: response?.response?.allHeaderFields as? [String: String])
                let taskResult = SnSRestTaskResult(result: result, error: nil)
                completionSource.set(result: taskResult)
                
            }
            let failureClosure: HTTPSessionOperationFailureClosure = { (response, error) -> Void in
                let result = SnSRestRequestResponse(request,
                                                    error: error,
                                                    statusCode: response?.response?.statusCode,
                                                    headers: response?.response?.allHeaderFields as? [String: String])
                let taskResult = SnSRestTaskResult(result: result, error: error)
                completionSource.set(result: taskResult)
            }
            
            let operation = SnSHTTPSessionOperation.operation(sessionManager: sessionManager,
                                                              httpMethod: request.httpMethod,
                                                              urlString: request.url,
                                                              encoding: request.encoding,
                                                              parameters: request.parameters,
                                                              heaeders: request.headers,
                                                              successClosure: successClosure,
                                                              failureClosure: failureClosure)
            
            operation.name = "com.snsrest.server.request.\(request.requestIdentifier)"
            self.operationQueue.addOperation(operation)
            
            return completionSource.task
        })
    }
}
