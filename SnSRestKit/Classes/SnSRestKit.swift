//
//  SnSRestKit.swift
//  Pods
//
//  Created by Adrien Greiner on 21/04/17.
//
//

import Foundation

typealias KitConfigurationHandler = (inout SnSRestKitConfiguration) -> Void

public struct SnSRestKitConfiguration {
    public var baseApiUrl: String?
    /**
     Enable logging will let SnSRestKit's controllers print log, error, crash events to the debugger.
     Logging is disabled by default.
     */
    public var loggingEnable: Bool
    public var cacheEnable: Bool
}

/**
 SnSRestKit Framework
 
 The primary public interface to customize and accessing SnSRestKit features.
 
 Use the SnSRestKit class to setup and configure SnSRestKit in your project.
 You must initialize the SnSRestKit before using any classes or provided features.
 You can perform only one initialization.
 
 */
final public class SnSRestKit {
    
    static var _coreManager: SnSRestKitManager! = nil;
    static var _configuration = SnSRestKitConfiguration(baseApiUrl: nil,
                                                        loggingEnable: false,
                                                        cacheEnable: false)
    static var isCachingEnabled = {
        return SnSRestKit._configuration.cacheEnable
    }
    
    static var isLoggingEnabled = {
        return SnSRestKit._configuration.loggingEnable
    }
    
    fileprivate static var _initialized = {
        return (_coreManager != nil)
    }
    
    // MARK: Initializers
    
    /**
     This class is not intended to be instances.
     */
    @available(*, unavailable)
    init() {
        fatalError()
    }
    
    /**
     Initialize SnSRestKit with configuration handler. The KitConfigurationHandler provide a KitConfiguration reference to customize for you needs.
     
     - important: This method should be called prior using SnSRestKit.
     
     - parameters:
        - closure: The KitConfigurationHandler closure with configuration to customize.
     */
    public static func initializeRestKit(withConfigurationClosure closure: KitConfigurationHandler) {
        if !_initialized() {
            // Set the default settings for SnSRestKit behaviour
            var config = SnSRestKitConfiguration(baseApiUrl: nil,
                                                 loggingEnable: false,
                                                 cacheEnable: true)
            // Pass configuration to closure
            closure(&config)
            // Copy new configuration
            _configuration = config
            
            // Intsantiate the core manager providing the kit configuration
            _coreManager = SnSRestKitManager(withConfiguration: _configuration)
            _coreManager?.launchKit()
            
            _coreManager = nil
            
        } else {
            print("<SnSRestKit> Already initialized once.")
        }
    }
    
}
