//
//  SnSRestRequestController.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import BoltsSwift

internal class SnSRestRequestController : SnSRestModule {
    
    internal lazy var _controllerOperationsQueue : DispatchQueue? = nil
    
    override func loadModule() {
        _controllerOperationsQueue = DispatchQueue(label: "com.snsrest.request.controllerOperationQueue",
                                                   qos: .utility,
                                                   attributes: .concurrent,
                                                   autoreleaseFrequency: .inherit,
                                                   target: nil)
    }

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
