//
//  SnSRestKitCore.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation

final class SnSRestKitCore : SnSRestModule {
    
    /// The DispatchQueue to access internal core modules
    //fileprivate var _controllerAccessorQueue : DispatchQueue
    
    /// The internal module managing SSRestRequest execution
    public private(set) lazy var requestController : SnSRestRequestController? = nil
    
    override func loadModule() {
        // Instantiate the desired request's controller depending on cahing preferences.
        requestController = (SnSRestKit.isCachingEnabled()) ?
            SnSRestCachedRequestController(withModulesDataSource: self.dataSource()!) :
            SnSRestRequestController(withModulesDataSource: self.dataSource()!)
    }
    
    override func unloadModule() {
        SnSRestConsoleLogger.log("SnSRestKitCore : Unloading Module...")

    }
    
}
