//
//  SnSRestRequestExecutor.swift
//  Pods
//
//  Created by Adrien Greiner on 23/04/17.
//
//

import Foundation
import BoltsSwift

final class SnSRestRequestExecutor: SnSRestModule, SnSRestRequestRunning {
    
    override func loadModule() {
        SnSRestConsoleLogger.log("SnSRestRequestExecutor : Loading Module...")
    }
    
    override func unloadModule() {
        SnSRestConsoleLogger.log("SnSRestRequestExecutor : Unloading Module...")
    }
    
    func runRequestAsync(_ request: SnSRestRequest, _ withOptions: SnSRestRequestRunningOptions) -> Task<Any> {
        return Task.init(true);
    }
}
