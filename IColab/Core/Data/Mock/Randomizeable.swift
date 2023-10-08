//
//  Randomizeable.swift
//  IColab
//
//  Created by Jeremy Raymond on 04/10/23.
//

import Foundation

protocol Randomizeable {
    associatedtype Element
    
    static var array: [Element] { get set }
}

extension Randomizeable {
    static func generateArray() -> [Element] {
        var array: [Element] = []
        
        for _ in 0...Int.random(in: 2..<self.array.count) {
            let element = self.array.randomElement()!
            array.append(element)
        }
        
        return array
    }
    
    static func initArray(count: Int, elementGenerator: () -> Element) -> [Element] {
        var array: [Element] = []
        
        for _ in 0...count {
            let element = elementGenerator()
            array.append(element)
        }
        
        return array
    }
}
