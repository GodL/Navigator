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
    
    associatedtype NavigatorAction: Action where NavigatorAction.From == Finder.ViewController, NavigatorAction.To == Create.ViewController, NavigatorAction.Context == Create.Context
    
    associatedtype Interceptor: Interceptable where Interceptor.Context == Create.Context
        
    var create: Create { get }
    
    var finder: Finder { get }
    
    var action: NavigatorAction { get }
     
    var interceptor: Interceptor? { get }
    
}

public struct Navigator<Create: Creatable, Finder: Findable, NavigatorAction: Action>: NavigatorType where Create.ViewController == NavigatorAction.To, Finder.ViewController == NavigatorAction.From, Create.Context == NavigatorAction.Context  {
    
    public var create: Create
    
    public let finder: Finder
    
    public let action: NavigatorAction
    
    public var interceptor: ContainerInterceptor<Create.Context>?
    
    public init(create: Create, finder: Finder, action: NavigatorAction) {
        self.create = create
        self.finder = finder
        self.action = action
    }
    
    public init<I: Interceptable>(create: Create, finder: Finder, action: NavigatorAction, interceptor: I) where I.Context == Create.Context {
        self.create = create
        self.finder = finder
        self.action = action
        self.interceptor = ContainerInterceptor(interceptor)
    }
    
    public init<I: Interceptable>(create: Create, finder: Finder, action: NavigatorAction, interceptors: I ...) where I.Context == Create.Context {
        self.create = create
        self.finder = finder
        self.action = action
        self.interceptor = ContainerInterceptor(InterceptorAssemble(interceptors))
    }
    
    public init<I: Interceptable>(create: Create, finder: Finder, action: NavigatorAction, interceptors: [I]) where I.Context == Create.Context {
        self.create = create
        self.finder = finder
        self.action = action
        self.interceptor = ContainerInterceptor(InterceptorAssemble(interceptors))
    }
}
