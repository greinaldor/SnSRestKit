//
//  SnSRestRequestController.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import BoltsSwift

class SnSRestRequestController : SnSRestModule {
    
    fileprivate lazy var _controllerOperationsQueue : DispatchQueue? = nil
    
    /**
     Load internal modules instances. Called during initialization.
     - warning: This method shouln't be called directly.
     */
    override func loadModule() {
        _controllerOperationsQueue = DispatchQueue(label: "com.snsrest.request.controllerOperationQueue",
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
        _controllerOperationsQueue = nil
    }
    
    func runRequestAsync(request: SnSRestRequest) -> Task<Any> {
        return self.taskFromModuleExecutor() { () -> Any in
            
            SnSRestConsoleLogger.log("run request")
            
            return Task.init(true);
        }
    }
}
