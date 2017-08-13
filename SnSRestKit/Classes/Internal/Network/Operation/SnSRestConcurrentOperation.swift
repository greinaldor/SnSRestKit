//
//  SnSRestConcurrentOperation.swift
//  Pods
//
//  Created by Adrien Greiner on 11/08/2017.
//
//

import Foundation

internal class SnSRestConcurrentOperation: Operation {
    
    override var isConcurrent: Bool {
        return true
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        if self.isCancelled {
            self.setFinished(isFinished: true)
            return
        }
        self.setExecuting(executing: true)
        self.main()
    }
    
    public func completeOperation() {
        self.setExecuting(executing: false)
        self.setFinished(isFinished: true)
    }
    
    public func setFinished(isFinished: Bool) {
        objc_sync_enter(self)
        if self.isFinished != isFinished {
            self.willChangeValue(forKey: "isFinished")
            self.setValue(isFinished, forKey: "isFinished")
            self.didChangeValue(forKey: "isFinished")
        }
        objc_sync_exit(self)
    }
    
    public func setExecuting(executing: Bool) {
        objc_sync_enter(self)
        if self.isExecuting != executing {
            self.willChangeValue(forKey: "isExecuting")
            self.setValue(executing, forKey: "isExecuting")
            self.didChangeValue(forKey: "isExecuting")
        }
        objc_sync_exit(self)
    }
}
