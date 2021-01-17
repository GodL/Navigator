//
//  Navigator
//  Create.swift
//  https://github.com/GodL/Navigator.git
//
//  Created by GodL on 2021/1/17.
//

public protocol Creatable {
    associatedtype ViewController
    
    associatedtype Context
    
    func build(with context: Context) -> ViewController
}
