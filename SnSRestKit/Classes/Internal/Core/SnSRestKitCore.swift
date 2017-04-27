//
//  SnSRestKitCore.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation

final class SnSRestKitCore: SnSRestModule {
    
    /// The DispatchQueue to access internal core modules
    //fileprivate var _controllerAccessorQueue : DispatchQueue
    
    /// The internal module managing SSRestRequest execution
    public private(set) var requestController: SnSRestRequestController?
    
    override func loadModule() {
        // Instantiate the desired request's controller depending on cahing preferences.
        guard let dataSource = self.dataSource() else { return }
        
        requestController = (SnSRestKit.isCachingEnabled()) ?
            SnSRestCachedRequestController(withModulesDataSource: dataSource) :
            SnSRestRequestController(withModulesDataSource: dataSource)
        
    }
    
    override func unloadModule() {
        SnSRestConsoleLogger.log("SnSRestKitCore : Unloading Module...")

    }
    
}
