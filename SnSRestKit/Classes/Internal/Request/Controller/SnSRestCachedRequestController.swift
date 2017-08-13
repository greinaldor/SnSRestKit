//
//  SnSRestCachedRequestController.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import BoltsSwift

class SnSRestCachedRequestController: SnSRestDefaultRequestController {
    
    override func loadModule() {
        super.loadModule()
        SnSRestConsoleLogger.log("SnSRestCachedRequestController: Loading Module...")
    }
    
    override func unloadModule() {
        super.unloadModule()
        SnSRestConsoleLogger.log("SnSRestCachedRequestController: Unloading Module...")
    }
    
    override func runRequestAsync(_ request: SnSRestRequest, _ options: SnSRestRequestRunningOptions) -> SnSRestTask {
        return self.taskFromModuleExecutor { () -> SnSRestTask in
            
            return super.runRequestAsync(request, options)
        }
    }
}
