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

final class SnSRestKitManager: SnSRestManagingModules {
    
    fileprivate let requestRunnerAccessQueue = DispatchQueue(label:"com.snsrest.coreManager.requestRunner.accessQueue")
    fileprivate let requestControllerAccessQueue = DispatchQueue(label:"com.snsrest.coreManager.requestController.accessQueue")
    fileprivate let requestServerAccessQueue = DispatchQueue(label:"com.snsrest.coreManager.requestServer.accessQueue")
    
    //***************************************************
    // The internal visible modules
    //***************************************************
    
    fileprivate var _requestController: SnSRestRequestController?
    fileprivate var _requestRunner: SnSRestRequestRunner?
    fileprivate var _requestServer: SnSRestRequestServer?

    public var requestController: SnSRestRequestController? {
        get {
            return self.requestControllerAccessQueue.sync {
                if self._requestController == nil {
                    self._requestController = SnSRestDefaultRequestController(with: self)
                }
                return self._requestController
            }
        }
        set {
            self.requestControllerAccessQueue.sync { self._requestController = newValue }
        }
    }
    
    public var requestRunner: SnSRestRequestRunner? {
        get {
            return self.requestRunnerAccessQueue.sync {
                if self._requestRunner == nil {
                    self._requestRunner = SnSRestRequestExecutor(with: self)
                }
                return self._requestRunner
            }
        }
        set {
            self.requestRunnerAccessQueue.sync { self._requestRunner = newValue }
        }
    }
    
    public var requestServer: SnSRestRequestServer? {
        get {
            return self.requestServerAccessQueue.sync {
                if self._requestServer == nil {
                    self._requestServer = SnSRestServer(with: self)
                }
                return self._requestServer
            }
        }
        set {
            self.requestServerAccessQueue.sync { self._requestServer = newValue }
        }
    }

    var sessionController: Any?
    
    public convenience required init(withConfiguration configuration: SnSRestKitConfiguration) {
        self.init()
        SnSRestConsoleLogger.log("SnSRestKitManager : Initializing")
        
        // Instantiate the desired request's controller depending on cahing preferences.        
    }
    
    deinit {
        _requestRunner = nil
        _requestController = nil
    }
    
    func launchKit() {
        SnSRestConsoleLogger.log("SnSRestKitManager : Launching")
        
        _ = self.requestController
        _ = self.requestRunner
        _ = self.requestServer
    }
}
