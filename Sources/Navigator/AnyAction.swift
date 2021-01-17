//  A type-erased Action value
//
//  AnyAction.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

public struct AnyAction: Action {
    
    let base: Any
    
    let _perform: (Any, Any, Any) -> Void
    
    public init<A: Action>(_ base: A) {
        self.base = base
        
        _perform = {
            guard let from = $0 as? A.From, let to = $1 as? A.To, let context = $2 as? A.Context else {  fatalError(" Generic parameter error ") }
            base.perform(from: from, to: to, context: context)
        }
    }
    
    public func perform(from: Any, to: Any, context: Any) {
        _perform(from, to, context)
    }
    
}
