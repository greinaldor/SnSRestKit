//
//  SnSRestKitCore.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation

final internal class SnSRestKitCore : SnSRestModule {
    
    /// The DispatchQueue to access internal core modules
    //fileprivate var _controllerAccessorQueue : DispatchQueue
    
    /// The internal module managing SSRestRequest execution
    public private(set) lazy var requestController : SnSRestRequestController? = nil
    
    override func loadModule() {
        
        SnSRestConsoleLogger.log("SnSRestKitCore : Loading Module...")
        
        // Instantiate the desired request's controller depending on cahing preferences.
        getModulesProvider()?.requestRunner
        
        requestController = (SnSRestKit.isCachingEnabled()) ?
            SnSRestCachedRequestController(withModulesDataSource: self.getModulesProvider()!) :
            SnSRestRequestController(withModulesDataSource: self.getModulesProvider()!)
    }
    
}
