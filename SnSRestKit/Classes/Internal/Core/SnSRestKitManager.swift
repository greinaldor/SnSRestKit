//
//  SnSRestKitManager.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import BoltsSwift

typealias SnSBoltTask = Task<Bool>

final internal class SnSRestKitManager : SnSRestKitManagerModules {
    
    lazy fileprivate var _core: SnSRestKitCore? = nil;
    
    lazy var requestRunner: SnSRestRequestRunning? = nil;
    lazy var sessionController: Any? = nil;
    
    private init() {}
    public convenience init?(withKitConfiguration configuration : SnSRestKitConfiguration) {
        self.init()
        
        SnSRestConsoleLogger.log("SnSRestKitManager : Initializing")
        
        // Consume configuration
        _core = SnSRestKitCore(withModulesDataSource: self)
    }
    
    internal func launchKit() {
        SnSRestConsoleLogger.log("SnSRestKitManager : Launching")
    }
}
