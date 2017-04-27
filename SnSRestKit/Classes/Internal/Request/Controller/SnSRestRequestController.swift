//
//  SnSRestRequestController.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import BoltsSwift

class SnSRestRequestController: SnSRestModule {
    
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
    
    func runRequestAsync(request: SnSRestRequest) -> SnSRestTask {
        
        return self.taskFromModuleExecutor { () -> SnSRestTask in
            
            // Return cancelledTask if request has been cancelled before execution
            if request.isCancelled {
                return Task.cancelledTask()
            }
            
            guard let requestExecutor = self.dataSource?.requestRunner else {
                return Task.cancelledTask()
            }
            
            return requestExecutor.runRequestAsync(request, .restRequestRunningOptionRetryIfFailed)
        }
    }
}
