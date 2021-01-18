//
//  Navigator.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

public protocol NavigatorType {
    
    associatedtype Create: Creatable
    
    associatedtype Finder: Findable
    
    associatedtype NavigatorAction: Action where NavigatorAction.From == Create.ViewController, NavigatorAction.To == Finder.ViewController, NavigatorAction.Context == Create.Context
    
    associatedtype Interceptor: Interceptable where Interceptor.Context == Create.Context
    
    var create: Create { get }
    
    var finder: Finder { get }
    
    var action: NavigatorAction { get }
    
    var interceptor: Interceptor { get }
}

extension NavigatorType {
    public var interceptor: EmptyInterceptor<Create.Context> { EmptyInterceptor() }
}

public struct Navigator<Create: Creatable, Finder: Findable, NavigatorAction: Action, Interceptor: Interceptable>: NavigatorType where Create.ViewController == NavigatorAction.From, Finder.ViewController == NavigatorAction.To, Create.Context == NavigatorAction.Context, Interceptor.Context == Create.Context  {
    
    public var create: Create
    
    public let finder: Finder
    
    public let action: NavigatorAction
    
    public var interceptor: InterceptorAssemble<Interceptor>
    
    public init(create: Create, finder: Finder, action: NavigatorAction, interceptor: Interceptor = EmptyInterceptor<Create.Context>() as! Interceptor) {
        self.init(create: create, finder: finder, action: action, interceptors: interceptor)
    }
    
    public init(create: Create, finder: Finder, action: NavigatorAction, interceptors: Interceptor ...) {
        self.create = create
        self.finder = finder
        self.action = action
        self.interceptor = InterceptorAssemble(interceptors)
    }
}
