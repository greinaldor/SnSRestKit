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
        
    }
    
    override func unloadModule() {
        SnSRestConsoleLogger.log("SnSRestKitCore : Unloading Module...")
    }
    
    func runRequestAsync(_ request: SnSRestRequest, _ withOptions: SnSRestRequestRunningOptions) -> Task<Any> {
        return Task.init(true);
    }
}
