//
//  Interceptable.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

public protocol Interceptable {
    
    associatedtype Context
        
    func perform(with context: Context, completion: @escaping (Result<Void, Swift.Error>) -> Void)
}
