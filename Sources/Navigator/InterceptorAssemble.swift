//
//  InterceptorAssemble.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

public struct InterceptorAssemble<Interceptor: Interceptable>: Interceptable {
    
    var interceptors: [Interceptor] = []
    
    public init(_ interceptors: [Interceptor]) {
        self.interceptors.append(contentsOf: interceptors)
    }
    
    public init(_ interceptors: Interceptor ...) {
        self.interceptors.append(contentsOf: interceptors)
    }
    
    public func perform(with context: Interceptor.Context, completion: @escaping (Result<Void, Error>) -> Void) {
        _perform(interceptors: interceptors, with: context, completion)
    }
    
    private func _perform(interceptors: [Interceptor], with context: Interceptor.Context, _ completion: @escaping (Result<Void, Error>) -> Void) {
        guard let interceptor = interceptors.first else { completion(.success(())); return}
         
        interceptor.perform(with: context) {
            switch $0 {
            case .success(_):
                self._perform(interceptors: Array(interceptors[1...]), with: context, completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
