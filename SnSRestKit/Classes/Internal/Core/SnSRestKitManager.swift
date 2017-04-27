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

final class SnSRestKitManager: SnSRestKitManagerModules {
    
    fileprivate var requestRunnerAccessQueue: DispatchQueue
    
    /// The internal module managing SSRestRequest execution
    fileprivate var requestController: SnSRestRequestController?
    
    /// The internal modules visible accross modules
    fileprivate var _requestRunner: SnSRestRequestRunner?
    var requestRunner: SnSRestRequestRunner? {
        get {
            return self.requestRunnerAccessQueue.sync {
                if self._requestRunner == nil {
                    self._requestRunner = SnSRestRequestExecutor(withModulesDataSource: self)
                }
                return self._requestRunner
            }
        }
        set {
            return self.requestRunnerAccessQueue.sync { self._requestRunner = newValue }
        }
    }

    var sessionController: Any?
    
    private init() {
        requestRunnerAccessQueue = DispatchQueue(label: "com.snsrest.coreManager.requestRunner.accessQueue")
        
    }
    
    public convenience init(withConfiguration configuration: SnSRestKitConfiguration) {
        self.init()
        
        SnSRestConsoleLogger.log("SnSRestKitManager : Initializing")
        
        // Instantiate the desired request's controller depending on cahing preferences.        
        requestController = (configuration.cacheEnable) ?
            SnSRestCachedRequestController(withModulesDataSource: self) :
            SnSRestRequestController(withModulesDataSource: self)
    }
    
    deinit {
        _requestRunner = nil
    }
    
    func launchKit() {
        SnSRestConsoleLogger.log("SnSRestKitManager : Launching")
        
    }
}
