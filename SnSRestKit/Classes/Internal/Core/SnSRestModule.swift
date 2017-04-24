//
//  SnSRestModule.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import BoltsSwift

internal typealias SnSRestModule = SnSRestModulepInterface<AnyObject>

internal protocol SnSRestKitModuleProtocol {    
    func loadModule()
    func unloadModule()
}

internal class SnSRestModulepInterface< T : AnyObject > : SnSRestKitModuleProtocol {
    
    internal private(set) weak var modulesProvider:  T? = nil
    internal let moduleName : String
    internal private(set) var moduleExecutor : Executor
    private  var moduleAccessQueue : DispatchQueue
    
    internal func loadModule() { fatalError("Should be overiddent in subclass") }
    internal func unloadModule() { fatalError("Should be overriden in subsclass") }
    
    internal init() {
        moduleName = "com.\(String(reflecting: type(of: self)).lowercased())"
        SnSRestConsoleLogger.log("\(moduleName): Initializing module")
        moduleAccessQueue = DispatchQueue(label: moduleName.lowercased() + ".moduleAccessQueue")
        moduleExecutor = Executor.queue(moduleAccessQueue)
    }
    
    public convenience init(withModulesDataSource dataSource : T) {
        self.init()
        modulesProvider = dataSource
        loadModule()
    }

    deinit {
        unloadModule()
    }
}

/// Module extended with Bolts features
extension SnSRestModulepInterface {
    func taskFromModuleExecutor(closure: @escaping ((Void) throws -> Any)) -> Task<Any> {
        return Task.init(moduleExecutor, closure: closure)
    }
    
}
