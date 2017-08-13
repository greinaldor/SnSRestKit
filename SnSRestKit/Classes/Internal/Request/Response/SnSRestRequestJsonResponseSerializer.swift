//
//  SnSRequestJsonResponseSerializer.swift
//  Pods
//
//  Created by Adrien Greiner on 11/08/2017.
//
//

import Foundation

open class SnSRestRequestJsonResponseSerializer: SnSRestModule, SnSRestRequestResponseSerializable {
    
    public var objectFromResponseSerializerClosure: ((SnSRestRequestResponse) -> AnyObject?)?
    
    public var errorFromResponseSerializerClosure: ((SnSRestRequestResponse) -> Error?)?
    
    override func loadModule() {
        
    }
    
    override func unloadModule() {
        
    }
    
    public func object(from response: SnSRestRequestResponse) -> AnyObject? {
        return nil
    }
    
    public func error(from resposne: SnSRestRequestResponse) -> Error? {
        return nil
    }
    
}
