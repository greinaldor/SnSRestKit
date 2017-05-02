//
//  SnSRestKitManagerModulesProvider.swift
//  Pods
//
//  Created by Adrien Greiner on 22/04/17.
//
//

import Foundation

protocol SnSRestManagingModules :
    class,
    SnSRestRequestRunnerProvider,
    SnSRestRequestControllerProvider,
    SnSRestSessionControllerProvider {}

typealias SnSRestRequestRunner = SnSRestRequestRunning & SnSRestModuleProtocol
protocol SnSRestRequestRunnerProvider {
    var requestRunner: SnSRestRequestRunner? { get }
}

typealias SnSRestRequestController = SnSRestRequestRunning & SnSRestModuleProtocol
protocol SnSRestRequestControllerProvider {
    var requestController: SnSRestRequestController? { get }
}

protocol SnSRestSessionControllerProvider {
    var sessionController : Any? { get }
}

extension SnSRestModulepInterface {
    var dataSource: SnSRestManagingModules? {
        return modulesProvider as? SnSRestManagingModules
    }
}
