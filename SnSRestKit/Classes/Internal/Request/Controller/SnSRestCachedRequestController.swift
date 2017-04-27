//
//  SnSRestCachedRequestController.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import BoltsSwift

internal class SnSRestCachedRequestController: SnSRestRequestController {
    
    override func loadModule() {
        super.loadModule()
        SnSRestConsoleLogger.log("SnSRestCachedRequestController: Loading Module...")
    }
    
    override func unloadModule() {
        super.unloadModule()
        SnSRestConsoleLogger.log("SnSRestCachedRequestController: Unloading Module...")
    }
    
    override func runRequestAsync(request: SnSRestRequest) -> SnSRestTask {
        return self.taskFromModuleExecutor { () -> Task<AnyObject> in
            
            return self.runRequestAsync(request: request)
        }
    }
}
