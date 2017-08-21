//
//  SnSRestRequestExecutor.swift
//  Pods
//
//  Created by Adrien Greiner on 23/04/17.
//
//

import Foundation
import BoltsSwift

final class SnSRestRequestExecutor: SnSRestModule {
    
    override func loadModule() {
        SnSRestConsoleLogger.log("SnSRestRequestExecutor : Loading Module...")
    }
    
    override func unloadModule() {
        SnSRestConsoleLogger.log("SnSRestRequestExecutor : Unloading Module...")
    }
    
}

extension SnSRestRequestExecutor : SnSRestRequestRunning {
    
    func runRequestAsync(_ request: SnSRestRequest, _ options: SnSRestRequestRunningOptions) -> SnSRestTask {
        return self.taskFromModuleExecutor { () -> SnSRestTask in
            // Return cancelledTask if request has been cancelled before execution
            if request.isCancelled {
                return Task.cancelledTask()
            }
                        
            guard let sessionManager = self.dataSource?.requestSessionManager else {
                return Task.cancelledTask()
            }
            return sessionManager.runRequestAsync(request, options)
        }
    }
}
