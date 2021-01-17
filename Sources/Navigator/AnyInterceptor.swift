//  A type-erased Interceptable value
//
//  AnyInterceptor.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

public struct AnyInterceptor: Interceptable {
    
    private typealias CompletionType = (Result<Void, Error>) -> Void
        
    private let base: Any
    
    private let _perform: (Any,@escaping CompletionType) -> Void
    
    public init<I: Interceptable>(_ base: I) {
        self.base = base
        
        _perform = { (context: Any, completion: @escaping CompletionType) in
            guard let context = context as? I.Context else { fatalError(" Generic parameter error ") }
            
            base.perform(with: context, completion: completion)
        }
    }
    
    public func perform(with context: Any, completion: @escaping (Result<Void, Error>) -> Void) {
        _perform(context, completion)
    }
}
