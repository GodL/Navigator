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
    
    var interceptor: Interceptor? { get }
}

public struct Navigator<Create: Creatable, Finder: Findable, NavigatorAction: Action, Interceptor: Interceptable>: NavigatorType where Create.ViewController == NavigatorAction.From, Finder.ViewController == NavigatorAction.To, Create.Context == NavigatorAction.Context, Interceptor.Context == Create.Context  {
    
    public var create: Create
    
    public let finder: Finder
    
    public let action: NavigatorAction
    
    public var interceptor: InterceptorAssemble<Interceptor>?
    
    public init(create: Create, finder: Finder, action: NavigatorAction, interceptor: Interceptor? = nil) {
        let `is`: [Interceptor]?
        if let i = interceptor {
            `is` = [i]
        }else {
            `is` = nil
        }
        self.init(create: create, finder: finder, action: action, interceptors: `is`)
    }
    
    public init(create: Create, finder: Finder, action: NavigatorAction, interceptors: [Interceptor]? = nil) {
        self.create = create
        self.finder = finder
        self.action = action
        if let i = interceptors, i.isEmpty == false {
            self.interceptor = InterceptorAssemble(i)
        }
    }
}
