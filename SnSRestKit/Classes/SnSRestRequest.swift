//
//  SnSRestRequest.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import Alamofire

final public class SnSRestRequest {

    /// The request's unique identifer
    public private(set) var requestIdentifier = UUID().uuidString
    
    /// The internal request's title
    public private(set) var title: String?
    
    /// The request's state.
    private var state: RequestState = .pending
    internal enum RequestState {
        case pending
        case running
        case cancelled
        case paused
        case error
    }
    
    /// The request's URL string.
    public var url: String
    
    /// The request's HTTP method.
    public var httpMethod: HTTPMethod = .get
    
    /// The request's HTTP Headers
    public var headers: HTTPHeaders?
    
    /// The request's encoding.
    public var encoding: URLEncoding = .default
    
    /// The request's parameters
    public var parameters: Parameters?
    
    init(_ url: String,
         httpMethod: HTTPMethod,
         parameters: Parameters? = nil,
         encoding: URLEncoding = .default,
         headers: HTTPHeaders?) {
        self.url = url
        self.httpMethod = httpMethod
        self.parameters = parameters
        self.headers = headers
        self.encoding = encoding
    }
    
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
