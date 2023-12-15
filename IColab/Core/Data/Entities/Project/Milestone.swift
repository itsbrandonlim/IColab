//
//  Milestone.swift
//  IColab
//
//  Created by Kevin Dallian on 05/09/23.
//

import Foundation

struct Milestone: Identifiable, Hashable{
    let id = UUID().uuidString
    var role: Role
    var goals: [Goal]
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    static func == (lhs: Milestone, rhs: Milestone) -> Bool {
        return lhs.id == rhs.id &&
        lhs.role == rhs.role
    }
    
    public func toDict() -> [String : Any] {
        return [
            "role" : self.role.rawValue,
            "goals" : self.goals.map({$0.toDict()})
        ]
    }
    
    static func decode(from data: [String : Any]) -> Milestone {
        let roleData = data["role"] as! String
        let role = Role(rawValue: roleData)
        
        let goalsData = (data["goals"] as? [[String:Any]] ?? []).map({Goal.decode(from: $0)})
        
        return Milestone(role: role!, goals: goalsData)
    }
}
