//
//  NavigatorRouter.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/18.
//

public protocol RouterType {
    func navigate<Navigator: NavigatorType, Context>(_ navigator: Navigator, context: Context) where Navigator.Create.Context == Context
}

final public class NavigatorRouter: RouterType {
    
    public static let router = NavigatorRouter()
    
    public func navigate<Navigator, Context>(_ navigator: Navigator, context: Context) where Navigator : NavigatorType, Context == Navigator.Create.Context {
        if let interceptor = navigator.interceptor {
            interceptor.perform(with: context) { result in
                if case .success(_) = result {
                    navigator.action.perform(from: navigator.create.build(with: context), to: navigator.finder.find(), context: context)
                }
            }
        }else {
            navigator.action.perform(from: navigator.create.build(with: context), to: navigator.finder.find(), context: context)
        }
    }
}
