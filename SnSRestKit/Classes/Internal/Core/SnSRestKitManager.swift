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

final class SnSRestKitManager : SnSRestKitManagerModules {
    
    fileprivate var _requestRunnerAccessQueue: DispatchQueue
    fileprivate var _core: SnSRestKitCore?
    
    fileprivate var _requestRunner: SnSRestRequestExecutor?
    
    lazy var requestRunner: SnSRestRequestRunner? = { _ in
        return self._requestRunnerAccessQueue.sync {
            self._requestRunner = SnSRestRequestExecutor(withModulesDataSource: self)
            return self._requestRunner
        }
    }()

    var sessionController: Any?;
    
    private init() {
        _requestRunnerAccessQueue = DispatchQueue(label: "com.snsrest.coreManager.requestRunner.accessQueue")
        
    }
    
    public convenience init(withConfiguration configuration : SnSRestKitConfiguration) {
        self.init()
        
        SnSRestConsoleLogger.log("SnSRestKitManager : Initializing")
        
        // Consume configuration
        _core = SnSRestKitCore(withModulesDataSource: self)
    }
    
    deinit {
        _requestRunner = nil
        _core = nil
    }
    
    func launchKit() {
        SnSRestConsoleLogger.log("SnSRestKitManager : Launching")
                
        if let requestController = _core?.requestController {
            requestController.modulesAccessExecutor
        }
        
    }
}
