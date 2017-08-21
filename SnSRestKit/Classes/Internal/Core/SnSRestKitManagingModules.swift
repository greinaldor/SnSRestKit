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
    SnSRestRequestSessionManagerProviding,
    SnSRestRequestResponseSerializerProviding,
    SnSRestRequestDataSerializerProviding {}

internal typealias SnSRestRequestRunner = SnSRestRequestRunning & SnSRestModuleProtocol
internal protocol SnSRestRequestRunnerProviding {
    var requestRunner: SnSRestRequestRunner? { get }
}

internal typealias SnSRestRequestController = SnSRestRequestRunning & SnSRestModuleProtocol
internal protocol SnSRestRequestControllerProviding {
    var requestController: SnSRestRequestController? { get }
}

public typealias SnSRestRequestSessionManager = SnSRestRequestRunning & SnSRestRequestServing & SnSRestModuleProtocol
internal protocol SnSRestRequestSessionManagerProviding {
    var requestSessionManager: SnSRestRequestSessionManager? { get set }
}

public typealias SnSRestRequestResponseSerializer = SnSRestRequestResponseSerializable & SnSRestModuleProtocol
internal protocol SnSRestRequestResponseSerializerProviding {
    var requestResponseSerializer: SnSRestRequestResponseSerializer? { get set }
}

public typealias SnSRestRequestDataSerializer = SnSRestRequestDataSerializable & SnSRestModuleProtocol
internal protocol SnSRestRequestDataSerializerProviding {
    var requestDataSerializer: SnSRestRequestDataSerializer? { get set }
}

extension SnSRestModulepInterface {
    var dataSource: SnSRestManagingModules? {
        return modulesProvider as? SnSRestManagingModules
    }
}
