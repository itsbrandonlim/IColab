//
//  MockChats.swift
//  IColab
//
//  Created by Jeremy Raymond on 01/10/23.
//

import Foundation

struct MockChats: Randomizeable {
    typealias Element = Chat
    
    static var randomProjectTitle: String = "Random Project Title"
    
    static var array: [Element] {
        MockChats.initArray(count: names.count) {
            return Element(title: names.randomElement()!, messages: MockMessages.generateArray(), type: ChatType.allCases.randomElement()!, projectName: randomProjectTitle)
        }
    }
    
    static var names: [String] = [
        "John",
        "Doe",
        "Kevin",
        "Dallian",
        "Gregorius",
        "Jeremy",
        "Raymond",
        "Metekohy",
        "Brandon",
        "Nicholas",
        "Marlim",
        "Dishcovery",
        "Icolab",
        "Slipi",
    ]
}
