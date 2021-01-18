//
//  EmptyInterceptor.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/18.
//

public struct EmptyInterceptor<Context>: Interceptable {
    
    public init() {}
    
    public func perform(with context: Context, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
}
