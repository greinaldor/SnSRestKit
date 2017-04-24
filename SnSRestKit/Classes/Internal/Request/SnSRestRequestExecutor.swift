//
//  SnSRestRequestExecutor.swift
//  Pods
//
//  Created by Adrien Greiner on 23/04/17.
//
//

import Foundation
import BoltsSwift

internal class SnSRestRequestExecutor: SnSRestModule, SnSRestRequestRunning {
    
    func runRequestAsync(_ request: SnSRestRequest, withOptions: SnSRestRequestRunningOptions) -> Task<Any> {
        return Task.init(true);
    }
    
}
