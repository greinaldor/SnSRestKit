//
//  SnSRestRequestRunning.swift
//  Pods
//
//  Created by Adrien Greiner on 23/04/17.
//
//

import Foundation
import BoltsSwift

enum SnSRestRequestRunningOptions {
    case SnSRestRequestRunningOptionRetryIfFailed
}

protocol SnSRestRequestRunning {
    func runRequestAsync(_ request: SnSRestRequest,_ withOptions: SnSRestRequestRunningOptions) -> Task<Any>
}
