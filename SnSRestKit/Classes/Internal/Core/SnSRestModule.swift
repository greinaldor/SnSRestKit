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

    func loadModule()
    func unloadModule()
}

class SnSRestModulepInterface<ModulesDataSourceT: AnyObject>: SnSRestModuleProtocol {
    
    private(set) weak var modulesProvider: ModulesDataSourceT?
    public private(set) var moduleName: String
    private(set) var modulesAccessExecutor: Executor
    private var moduleAccessQueue: DispatchQueue
    
    func loadModule() { fatalError("Should be overidden in subclass") }
    func unloadModule() {
        modulesProvider = nil
    }
    
    init() {
        moduleName = "com.\(String(reflecting: type(of: self)).lowercased())"
        SnSRestConsoleLogger.log("\(moduleName): Initializing module")
        moduleAccessQueue = DispatchQueue(label: moduleName.lowercased() + ".moduleAccessQueue")
        modulesAccessExecutor = Executor.queue(moduleAccessQueue)
    }
    
    public convenience init(withModulesDataSource dataSource: ModulesDataSourceT) {
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
        return Task.init(self.modulesAccessExecutor, closure: closure)
    }
    
}
