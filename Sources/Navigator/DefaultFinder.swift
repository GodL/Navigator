//
//  DefaultFinder.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

import UIKit

public struct RootFinder<Controller: UIViewController>: Findable {
    public init() {}
    
    public func find() -> Controller {
        guard let vc = UIApplication.shared.windows.first?.rootViewController as? Controller else { fatalError("Generic parameter error") }
        return vc
    }
}

public struct VoidFinder: Findable {
    
    public init() {}
    
    public func find() -> Void {}
}
