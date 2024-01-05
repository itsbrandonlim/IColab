//
//  Member.swift
//  IColab
//
//  Created by Jeremy Raymond on 01/10/23.
//

import Foundation

struct Member: Identifiable, Equatable{
    let id: UUID = UUID()
    
    var workerID : String
    var role: Role
    
    static func decode(from data: [String:Any]) -> Member {
        let workerID = data["workerID"] as! String
        let role = Role(rawValue: (data["role"] as! String))
        return Member(workerID: workerID, role: role!)
    }
    
    func toDict() -> [String:Any]{
        return [
            "workerID" : self.workerID,
            "role" : self.role.rawValue
        ]
    }
}
