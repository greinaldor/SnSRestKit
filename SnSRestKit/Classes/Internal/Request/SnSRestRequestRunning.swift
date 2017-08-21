//
//  SnSRestRequestRunning.swift
//  Pods
//
//  Created by Adrien Greiner on 23/04/17.
//
//

import Foundation
import BoltsSwift

public enum SnSRestRequestRunningOptions {
    case restRequestRunningOptionRetryIfFailed
}

public struct SnSRestTaskResult {
    private(set) var result: Any?
    private(set) var error: Error?
    
    public func hasFaulted() -> Bool { return self.error != nil }
    public func hasSucceeded() -> Bool { return self.result != nil }
}

public typealias SnSRestTask = Task<SnSRestTaskResult>

public protocol SnSRestRequestRunning {
    
    func runRequestAsync(_ request: SnSRestRequest, _ withOptions: SnSRestRequestRunningOptions) -> SnSRestTask
}
