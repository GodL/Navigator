//
//  ContainerInterceptor.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

public struct ContainerInterceptor<Context>: Interceptable {
    
    private typealias CompletionType = (Result<Void, Error>) -> Void
        
    private let base: Any
    
    private let _perform: (Context,@escaping CompletionType) -> Void
    
    public init<I: Interceptable>(_ base: I) where I.Context == Context {
        self.base = base
        
        _perform = { (context: Context, completion: @escaping CompletionType) in
            
            base.perform(with: context, completion: completion)
        }
    }
    
    public func perform(with context: Context, completion: @escaping (Result<Void, Error>) -> Void) {
        _perform(context, completion)
    }
}
