//
//  SnSError.swift
//  Pods
//
//  Created by Adrien Greiner on 02/05/17.
//
//

import Foundation

public enum SnSError: Error {
    case defaultError
    case unknownError
    
    public var localizedDescription: String {
        switch self {
        case .defaultError:
            return "Default Error"
        default:
            return "Undefined error"
        }
    }
}
