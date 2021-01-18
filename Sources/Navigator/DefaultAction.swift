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


public struct PresentAction<From: UIViewController, To: UIViewController, Context>: Action {
    
    public init() {}
    
    public func perform(from: From, to: To, context: Context) {
        from.present(to, animated: true, completion: nil)
    }
}

public struct PopAction<From: UIViewController>: Action {
    
    public init() {}
    
    public func perform(from: From, to: Void, context: Void) {
        from.navigationController?.popViewController(animated: true)
    }
}

public struct DismissAction<From: UIViewController>: Action {
    
    public init() {}
    
    public func perform(from: From, to: Void, context: Void) {
        from.dismiss(animated: true, completion: nil)
    }
}
