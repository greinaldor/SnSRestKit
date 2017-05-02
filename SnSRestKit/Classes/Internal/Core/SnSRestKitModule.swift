//
//  SnSRestModule.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation
import BoltsSwift

typealias SnSRestModule = SnSRestModulepInterface<AnyObject>

protocol SnSRestModuleProtocol {
    
    var moduleName: String { get }
    var moduleAccessQueue: DispatchQueue { get }

    func loadModule()
    func unloadModule()
}

class SnSRestModulepInterface<ModulesDataSource: AnyObject>: SnSRestModuleProtocol {
    
    public private(set) var moduleName: String
    private(set) weak var modulesProvider: ModulesDataSource?
    private(set) var modulesAccessExecutor: Executor
    var moduleAccessQueue: DispatchQueue
    
    func loadModule() { fatalError("Should be overridden in subclass") }
    func unloadModule() { fatalError("Should be overridden in subclass")    }
    
    init() {
        moduleName = "com.\(String(reflecting: type(of: self)).lowercased())"
        SnSRestConsoleLogger.log("\(moduleName): Initializing module")
        moduleAccessQueue = DispatchQueue(label: moduleName.lowercased() + ".moduleAccessQueue")
        modulesAccessExecutor = Executor.queue(moduleAccessQueue)
    }
    
    public convenience init(with dataSource: ModulesDataSource) {
        self.init()
        modulesProvider = dataSource
        loadModule()
    }

    deinit {
        unloadModule()
        modulesProvider = nil
    }
}

/// Module extended with Bolts features
extension SnSRestModulepInterface {
    func taskFromModuleExecutor(closure: @escaping ((Void) throws -> SnSRestTask)) -> SnSRestTask {
        return Task.init(self.modulesAccessExecutor, closure: closure)
    }
}
