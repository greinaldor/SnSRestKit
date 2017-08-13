//
//  File.swift
//  Pods
//
//  Created by Adrien Greiner on 11/08/2017.
//
//

import Foundation

public protocol SnSRestRequestResponseSerializable {
    
    var objectFromResponseSerializerClosure: ((SnSRestRequestResponse) -> AnyObject?)? { get set }
    var errorFromResponseSerializerClosure: ((SnSRestRequestResponse) -> Error?)? { get set }
    
    func object(from response: SnSRestRequestResponse) -> AnyObject?
    func error(from resposne: SnSRestRequestResponse) -> Error?
}
