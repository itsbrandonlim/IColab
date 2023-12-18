//
//  Request.swift
//  IColab
//
//  Created by Kevin Dallian on 17/10/23.
//

import Foundation
import FirebaseFirestore

struct Request : Equatable{
    var id : String
    var workerID : String
    var name: String
    var role : Role
    var date : Date
    
    public func toDict() -> [String : Any] {
        return [
            "id" : self.id,
            "workerID" : self.workerID,
            "name" : self.name,
            "role" : self.role.rawValue,
            "date" : Timestamp(date: self.date)
        ]
    }
    
    static func decode(from data: [String:Any]) -> Request {
        let id = data["id"] as! String
        let workerID = data["workerID"] as! String
        let role = Role(rawValue: (data["role"] as! String))
        let name = data["name"] as! String
        let date = (data["date"] as! Timestamp).dateValue()
        return Request(id: id, workerID: workerID, name: name, role: role!, date: date)
    }
}

enum RequestState {
    case notReviewed
    case approved
    case rejected
}
