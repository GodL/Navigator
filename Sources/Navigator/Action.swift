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
