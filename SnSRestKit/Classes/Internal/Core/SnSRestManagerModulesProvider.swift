//
//  SnSRestKitManagerModulesProvider.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation

protocol SnSRestKitManagerModules :
    class,
    SnSRestRequestRunnerProvider,
    SnSRestSessionControllerProvider {}

extension SnSRestModulepInterface {
    
    var dataSource: SnSRestKitManagerModules? {
        return modulesProvider as? SnSRestKitManagerModules
    }
    
//    public func dataSource() -> SnSRestKitManagerModules? {
//        return modulesProvider as? SnSRestKitManagerModules
//    }
}

typealias SnSRestRequestRunner = SnSRestRequestRunning & SnSRestModuleProtocol
protocol SnSRestRequestRunnerProvider {
    var requestRunner: SnSRestRequestRunner? { get }
}

protocol SnSRestSessionControllerProvider {
    var sessionController : Any? { get }
}
