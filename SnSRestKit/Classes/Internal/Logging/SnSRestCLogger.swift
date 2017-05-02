//
//  SnSRestCLogger.swift
//  Pods
//
//  Created by Adrien Greiner on 23/04/17.
//
//

import Foundation

class SnSRestConsoleLogger {
    
    public static func log(_ message: String) {
        if SnSRestKit.isLoggingEnabled {
            print(message)
        }
    }
}
