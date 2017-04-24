//
//  SnSRestKitManagerModulesProvider.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation

internal protocol SnSRestKitManagerModules :
    class,
    SnSRestRequestRunnerProvider,
    SnSRestSessionControllerProvider {}

extension SnSRestModulepInterface {
    public func getModulesProvider() -> SnSRestKitManagerModules? {
        return modulesProvider as? SnSRestKitManagerModules
    }
}

internal protocol SnSRestRequestRunnerProvider {
    var requestRunner : SnSRestRequestRunning? { get }
}

internal protocol SnSRestSessionControllerProvider {
    var sessionController : Any? { get }
}
