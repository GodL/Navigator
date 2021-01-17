//
//  Navigator
//  DefaultCreate.swift
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

import UIKit

public struct DefaultCreate<Controller: UIViewController>: Creatable {
    
    public init() {}
    
    public func build(with context: Any?) -> Controller {
        Controller()
    }
}

public struct VoidCreate: Creatable {
    
    public init() {}
    
    public func build(with context: Void) -> Void {}
}
