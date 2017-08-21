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
    
    private let requestRunnerAccessQueue = DispatchQueue(label: "com.snsrest.coreManager.requestRunner.accessQueue")
    private let requestControllerAccessQueue = DispatchQueue(label: "com.snsrest.coreManager.requestController.accessQueue")
    private let requestServerAccessQueue = DispatchQueue(label: "com.snsrest.coreManager.requestServer.accessQueue")
    private let requestResponseSerializerAccessQueue = DispatchQueue(label: "com.snsrest.coreManager.requestResponseSerializer.accessQueue")
    private let requestDataSerializerAccessQueue = DispatchQueue(label: "com.snsrest.coreManager.requestDataSerializer.accessQueue")
    
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
        _ = self.requestSessionManager
        _ = self.requestResponseSerializer
    }
    
    //***************************************************
    // MARK: - Internaly visible modules -
    //***************************************************
    
    // MARK: Request Controller
    private var _requestController: SnSRestRequestController?
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
    
    // MARK: - Request Runner
    private var _requestRunner: SnSRestRequestRunner?
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
    
    // MARK: - Request Server
    private var _requestSessionManager: SnSRestRequestSessionManager?
    public var requestSessionManager: SnSRestRequestSessionManager? {
        get {
            return self.requestServerAccessQueue.sync {
                if self._requestSessionManager == nil {
                    self._requestSessionManager = SnSRestHTTPSessionManager(with: self)
                }
                return self._requestSessionManager
            }
        }
        set {
            self.requestServerAccessQueue.sync { self._requestSessionManager = newValue }
        }
    }
    
    //***************************************************
    // MARK: - Publicaly visible modules -
    //***************************************************
    
    // MARK: Request Data Serializer
    private var _requestDataSerializer: SnSRestRequestDataSerializer?
    public var requestDataSerializer: SnSRestRequestDataSerializer? {
        get {
            return self.requestDataSerializerAccessQueue.sync {
                if self._requestDataSerializer == nil {
                    self._requestDataSerializer = SnSRestRequestDataJsonSerializer(with: self)
                }
                return self._requestDataSerializer
            }
        }
        set {
            self.requestDataSerializerAccessQueue.sync { self._requestDataSerializer = newValue }
        }
    }
    
    // MARK: Request Response Serializer
    private var _requestResponseSerializer: SnSRestRequestResponseSerializer?
    public var requestResponseSerializer: SnSRestRequestResponseSerializer? {
        get {
            return self.requestResponseSerializerAccessQueue.sync {
                if self._requestResponseSerializer == nil {
                    self._requestResponseSerializer = SnSRestRequestJsonResponseSerializer(with: self)
                }
                return self._requestResponseSerializer
            }
        }
        set {
            self.requestResponseSerializerAccessQueue.sync { self._requestResponseSerializer = newValue }
        }
    }
}
