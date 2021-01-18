//
//  Navigators.swift
//  Example
//
//  Created by GodL on 2021/1/18.
//

import Navigator
import UIKit

struct Navigators {
    static let push = Navigator(create: NavigatorCreate(), finder: RootFinder<UIViewController>(), action: SystemAction())
    
    static let present = Navigator(create: NavigatorCreate(), finder: RootFinder<UIViewController>(), action: PresentAction())
    
    static let pop = Navigator(create: VoidCreate(), finder: CurrentFinder<UIViewController>(), action: PopAction())
    
    static let dismiss = Navigator(create: VoidCreate(), finder: RootFinder<UIViewController>(), action: DismissAction())
    
    static let login = Navigator(create: LoginCreate(), finder: RootFinder<UIViewController>(), action: PresentAction())
    
    static let pushWithInterceptor = Navigator(create: NavigatorCreate(), finder: RootFinder<UIViewController>(), action: SystemAction(), interceptor: LoginInterceptor())
}

let storyBoard = UIStoryboard(name: "Main", bundle: nil)


struct NavigatorCreate: Creatable {
    func build(with context: String) -> NavigatorController {
        let vc = storyBoard.instantiateViewController(identifier: "Navigator") as! NavigatorController
        vc.buttonTitle = context
        return vc
    }
}

struct CurrentFinder<Controller: UIViewController>: Findable {
    func find() -> Controller {
        let root: RootFinder<UINavigationController> = RootFinder()
        return root.find().topViewController as! Controller
    }
}

struct LoginCreate: Creatable {
    func build(with context: @escaping () -> Void) -> LoginController {
        let vc = storyBoard.instantiateViewController(identifier: "Login") as! LoginController
        vc.completion = context
        return vc
    }
}

var isLogin = false


struct LoginInterceptor: Interceptable {
    func perform(with context: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if isLogin {
            completion(.success(()))
        }else {
            Navigators.login.navigate {
                completion(.success(()))
            }
        }
    }
}
