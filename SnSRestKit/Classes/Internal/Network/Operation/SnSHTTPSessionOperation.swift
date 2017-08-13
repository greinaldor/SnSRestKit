//
//  SnSHTTPSessionOperation.swift
//  Pods
//
//  Created by Adrien Greiner on 12/08/2017.
//
//

import Foundation
import Alamofire

typealias HTTPSessionOperationSuccessClosure = (URLRequest?, Data?) -> Void
typealias HTTPSessionOperationFailureClosure = (URLRequest?, Error) -> Void

internal class SnSHTTPSessionOperation: SnSRestConcurrentOperation {
    
    internal var sessionManager: SessionManager
    internal var httpMethod: HTTPMethod
    internal var url: String
    internal var encoding: URLEncoding = .default
    internal var parameters: Parameters?
    internal var headers: [String: String]?
    internal var successClosure: HTTPSessionOperationSuccessClosure?
    internal var failureClosure: HTTPSessionOperationFailureClosure?
    
    internal weak var task: URLSessionTask?
    
    public class func operation(sessionManager: SessionManager,
                                httpMethod: HTTPMethod,
                                urlString: String,
                                encoding: URLEncoding = .default,
                                parameters: Parameters,
                                heaeders: [String: String]? = nil,
                                successClosure: HTTPSessionOperationSuccessClosure? = nil,
                                failureClosure: HTTPSessionOperationFailureClosure? = nil) -> SnSRestConcurrentOperation {
        let sessionOperation = SnSHTTPSessionOperation(url: urlString,
                                                       httpMethod: httpMethod,
                                                       sessionsManager: sessionManager)
        sessionOperation.encoding = encoding
        sessionOperation.parameters = parameters
        sessionOperation.headers = heaeders
        sessionOperation.successClosure = successClosure
        sessionOperation.failureClosure = failureClosure
        return sessionOperation
    }
    
    init(url: String, httpMethod: HTTPMethod, sessionsManager: SessionManager) {
        self.httpMethod = httpMethod
        self.url = url
        self.sessionManager = sessionsManager
        super.init()
    }
    
    override func main() {
        let request = self.sessionManager.request(self.url,
                                                  method: self.httpMethod,
                                                  parameters: self.parameters,
                                                  encoding: self.encoding,
                                                  headers: self.headers)
        request.responseData { [weak self] (response) in
            if let error = response.error, let failingClosure = self?.failureClosure {
                failingClosure(response.request, error)
            } else if let successClosure = self?.successClosure {
                successClosure(response.request, response.data)
            }
            self?.completeOperation()
        }
        request.resume()
        self.task = request.task
    }
    
    override func completeOperation() {
        self.successClosure = nil
        self.failureClosure = nil
        super.completeOperation()
    }
    
    public func resume() {
        self.task?.resume()
    }
    
    public func suspend() {
        self.task?.suspend()
    }
    
    override func cancel() {
        self.task?.cancel()
        super.cancel()
    }
}
