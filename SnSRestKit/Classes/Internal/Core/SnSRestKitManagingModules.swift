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

internal typealias SnSRestRequestServer = SnSRestRequestRunning & SnSRestRequestServing & SnSRestModuleProtocol
internal protocol SnSRestRequestServerProviding {
    var requestServer: SnSRestRequestServer? { get }
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
