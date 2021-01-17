//
//  DefaultAction.swift
//  Navigator
//  https://github.com/GodL/Navigator

//  Created by GodL on 2021/1/17.
//

import UIKit

public struct SystemAction<From: UIViewController, To: UIViewController, Context>: Action {
    
    public init() {}
    
    public func perform(from: From, to: To, context: Context) {
        from.show(to, sender: nil)
    }
}
