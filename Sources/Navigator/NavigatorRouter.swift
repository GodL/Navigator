//
//  NavigatorRouter.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/18.
//

public protocol RouterType {
    func navigate<Navigator: NavigatorType>(_ navigator: Navigator, context: Navigator.Create.Context)
}

final public class NavigatorRouter: RouterType {
    
    public static let router = NavigatorRouter()
    
    public func navigate<Navigator>(_ navigator: Navigator, context: Navigator.Create.Context) where Navigator : NavigatorType {
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
