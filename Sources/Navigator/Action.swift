//
//  Action.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

public protocol Action {
    associatedtype From
    
    associatedtype To
    
    associatedtype Context
    
    func perform(from: From, to: To, context: Context)
}

public protocol Service: Action where From == Void, To == Void {
    func perform(with context: Context)
}

extension Service {
    public func perform(from: From, to: To, context: Context) {
        perform(with: context)
    }
}
