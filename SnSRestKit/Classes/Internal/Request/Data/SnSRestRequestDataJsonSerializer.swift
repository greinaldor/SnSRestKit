//
//  SnSRestRequestDataJsonSerializer.swift
//  Pods
//
//  Created by Adrien Greiner on 11/08/2017.
//
//

import Foundation

open class SnSRestRequestDataJsonSerializer: SnSRestModule, SnSRestRequestDataSerializable {
    
    public var dataFromRequestDataSerializerClosure: ((SnSRestRequest) -> AnyObject?)?
    
    override func loadModule() {
        
    }
    
    override func unloadModule() {
        
    }
    
    public func data(from request: SnSRestRequest) -> AnyObject? {
        return nil
    }
}
