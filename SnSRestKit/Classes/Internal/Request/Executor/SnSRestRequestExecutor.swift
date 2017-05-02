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
    
    func runRequestAsync(_ request: SnSRestRequest, _ withOptions: SnSRestRequestRunningOptions) -> SnSRestTask {
        return Task.init(SnSRestTaskResult())
    }
    
}
