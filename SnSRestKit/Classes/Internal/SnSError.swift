//
//  SnSError.swift
//  Pods
//
//  Created by Adrien Greiner on 02/05/17.
//
//

import Foundation

public typealias ErrorType = (Int, String)

public enum SnSError: Int, Error {
    
    case internalError = -1
    case unknownError = -3
    
    public var localizedError: ErrorType {
        return (self.rawValue, self.localizedDescription)
    }
    
    public var localizedDescription: String {
        switch self {
        case .unknownError:
            return "Unknown error. Treated as fatal error"
        case .internalError:
            return "Internal error occured for reason: "
        }
    }
}
