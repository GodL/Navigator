//
//  Navigators.swift
//  Example
//
//  Created by GodL on 2021/1/18.
//

import Navigator
import UIKit

struct Navigators {
    static let push = Navigator<DefaultCreate<RootController>.Type, RootFinder<UIViewController>, SystemAction<RootController, UIViewController, Any?>>(create: DefaultCreate<RootController>, finder: RootFinder<UIViewController>(), action: SystemAction<RootController, UIViewController, Any?>())
    
    static let present = Navigator(create: def, finder: <#T##_#>, action: <#T##_#>)
}
