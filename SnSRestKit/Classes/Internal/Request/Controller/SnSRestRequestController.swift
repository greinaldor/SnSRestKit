//
//  SnSRestRequestController.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import BoltsSwift

class SnSRestDefaultRequestController: SnSRestModule, SnSRestRequestRunning {
    
    fileprivate var controllerOperationsQueue: DispatchQueue?
    
    /**
     Load internal modules instances. Called during initialization.
     - warning: This method shouln't be called directly.
     */
    override func loadModule() {
        controllerOperationsQueue = DispatchQueue(label: "com.snsrest.request.controllerOperationQueue",
                                                  qos: .utility,
                                                  attributes: .concurrent,
                                                  autoreleaseFrequency: .inherit,
                                                  target: nil)
    }

    /**
     Unload internal modules instances. Called during initialization.
     - warning: This method shouln't be called directly.
     */
    override func unloadModule() {
        controllerOperationsQueue = nil
    }
    
    func runRequestAsync(_ request: SnSRestRequest, _ options: SnSRestRequestRunningOptions) -> SnSRestTask {
        return self.taskFromModuleExecutor { [unowned self] () -> SnSRestTask in
            
            // Return cancelledTask if request has been cancelled before execution
            if request.isCancelled {
                return Task.cancelledTask()
            }
            
            guard let requestExecutor = self.dataSource?.requestRunner
                 /*let requestServer = self.dataSource?.requestServer*/ else {
                return Task.cancelledTask()
            }
            
            return requestExecutor.runRequestAsync(request, options).continueWithTask(continuation: { (task) -> SnSRestTask in
                if !task.cancelled && task.completed {
                    return task.faulted ?
                        self.handleRequest(onError: task.error) :
                        self.handleRequest(onSucceed: task.result)
                }
                return task
            })
        }
    }
    
    private func handleRequest(onSucceed result: SnSRestTaskResult?) -> SnSRestTask {
        return Task.init(SnSRestTaskResult())
    }
    
    private func handleRequest(onError error: Error?) -> SnSRestTask {
        return Task.cancelledTask()
    }
    
}
