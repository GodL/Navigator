//
//  Navigators.swift
//  Example
//
//  Created by GodL on 2021/1/18.
//

import Navigator
import UIKit

struct Navigators {
    static let push = Navigator(create: NavigatorCreate(), finder: RootFinder<UIViewController>(), action: SystemAction<NavigatorController, UIViewController, String>())
    
    static let present = Navigator(create: NavigatorCreate(), finder: RootFinder<UIViewController>(), action: PresentAction<NavigatorController, UIViewController, String>())
    
    static let pop = Navigator(create: VoidCreate(), finder: RootFinder<UIViewController>(), action: PopAction<UIViewController>())
}


struct NavigatorCreate: Creatable {
    func build(with context: String) -> NavigatorController {
        let vc = NavigatorController(nibName: nil, bundle: nil)
        vc.buttonTitle = context
        return vc
    }
    
}
