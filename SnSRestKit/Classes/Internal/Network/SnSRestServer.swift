//
//  SnSRestServer.swift
//  Pods
//
//  Created by Adrien Greiner on 02/05/17.
//
//

import Foundation
import BoltsSwift

protocol SnSRestRequestServing {
    
}

class SnSRestServer: SnSRestModule, SnSRestRequestServing, SnSRestRequestRunning {
    
    override func loadModule() {
        
    }
    
    override func unloadModule() {
        
    }
    
    func runRequestAsync(_ request: SnSRestRequest, _ withOptions: SnSRestRequestRunningOptions) -> SnSRestTask {
        return Task.init("")
    }
}
