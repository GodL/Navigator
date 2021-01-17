//
//  Findable.swift
//  Navigator
//  https://github.com/GodL/Navigator
//
//  Created by GodL on 2021/1/17.
//

public protocol Findable {
    
    associatedtype ViewController
    
    func find() -> ViewController
}
