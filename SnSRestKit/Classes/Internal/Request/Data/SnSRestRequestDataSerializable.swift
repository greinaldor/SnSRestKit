//
//  SnSRestRequestDataSerializable.swift
//  Pods
//
//  Created by Adrien Greiner on 11/08/2017.
//
//

import Foundation

public protocol SnSRestRequestDataSerializable {
    
    var dataFromRequestDataSerializerClosure: ((SnSRestRequest) -> AnyObject?)? { get set }
    
    func data(from request: SnSRestRequest) -> AnyObject?
}
