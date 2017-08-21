//
//  SnSRestRequestResponse.swift
//  Pods
//
//  Created by Adrien Greiner on 11/08/2017.
//
//

import Foundation

final public class SnSRestRequestResponse {
    
    private(set) var data: Data?
    private(set) var error: Error?
    private(set) var responseStatusCode: Int?
    private(set) var responseHeaders: [String: String]?
    private(set) var request: SnSRestRequest?
    
    init(_ request: SnSRestRequest? = nil, data: Data?, statusCode: Int?, headers: [String: String]? = nil) {
        self.request = request
        self.responseStatusCode = statusCode
        self.responseHeaders = headers
        self.data = data
    }
    
    init(_ request: SnSRestRequest? = nil, error: Error, statusCode: Int?, headers: [String: String]? = nil) {
        self.request = request
        self.responseStatusCode = statusCode
        self.responseHeaders = headers
        self.error = error
    }
    
}
