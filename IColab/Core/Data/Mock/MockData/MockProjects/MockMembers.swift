//
//  MockMembers.swift
//  IColab
//
//  Created by Jeremy Raymond on 04/10/23.
//

import Foundation

struct MockMembers: Randomizeable {
    typealias Element = Member
    
    static var array: [Member] {
        MockMembers.initArray(count: 5) {
            return Member(workerID: UUID().uuidString, role: Role.allCases.randomElement()!)
        }
    }
}
