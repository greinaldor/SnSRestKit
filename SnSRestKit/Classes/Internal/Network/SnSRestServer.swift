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

protocol SnSRestRequestServing {
    
}

class SnSRestError: Error {
    var localizedDescription: String {
        return "Failed"
    }
}

class SnSRestServer: SnSRestModule, SnSRestRequestServing, SnSRestRequestRunning {
    
    fileprivate let operationQueue = OperationQueue()
    fileprivate var sessionManager: SessionManager?
    
    override func loadModule() {
        
        self.operationQueue.maxConcurrentOperationCount = 120
        self.operationQueue.name = "com.snsrest.core.server.operationQueue"
        
        let sessionConfiguration = URLSessionConfiguration.background(withIdentifier: "com.snsrest.core.server.operationQueue")
        
        self.sessionManager = SessionManager(configuration: sessionConfiguration)
    }
    
    override func unloadModule() {
        
    }
    
    func runRequestAsync(_ request: SnSRestRequest, _ withOptions: SnSRestRequestRunningOptions) -> SnSRestTask {
        return self.taskFromModuleExecutor(closure: { () -> SnSRestTask in
            
            // Return cancelledTask if request has been cancelled before execution
            if request.isCancelled {
                return Task.cancelledTask()
            }
            
            return self.performRequest()
        })
    }
    
    private func performRequest() -> SnSRestTask {
        return self.taskFromModuleExecutor(closure: { () -> SnSRestTask in
          
            let completionSource = TaskCompletionSource<SnSRestTaskResult>()
            
            completionSource.set(result: SnSRestTaskResult())
            return completionSource.task
        })
    }
}
