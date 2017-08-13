//
//  SnSRestRequest.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation

fileprivate enum RequestState {
    case pending
    case running
    case cancelled
    case paused
    case error
}

final public class SnSRestRequest {
    
    fileprivate var state: RequestState = .pending

    public private(set) var title: String?    
    
    public func cancel() {
        state = .cancelled
    }
    
    var isCancelled: Bool {
        switch state {
        case .cancelled:
            return true
        default:
            return false
        }
    }
}
