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
    SnSRestRequestRunnerProviding,
    SnSRestRequestControllerProviding,
    SnSRestRequestServerProviding,
    SnSRestSessionControllerProvider {}

typealias SnSRestRequestRunner = SnSRestRequestRunning & SnSRestModuleProtocol
protocol SnSRestRequestRunnerProviding {
    var requestRunner: SnSRestRequestRunner? { get }
}

typealias SnSRestRequestController = SnSRestRequestRunning & SnSRestModuleProtocol
protocol SnSRestRequestControllerProviding {
    var requestController: SnSRestRequestController? { get }
}

typealias SnSRestRequestServer = SnSRestRequestServing & SnSRestModuleProtocol
protocol SnSRestRequestServerProviding {
    var requestServer: SnSRestRequestServer? { get }
}

protocol SnSRestSessionControllerProvider {
    var sessionController : Any? { get }
}

extension SnSRestModulepInterface {
    var dataSource: SnSRestManagingModules? {
        return modulesProvider as? SnSRestManagingModules
    }
}
