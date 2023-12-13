//
//  Request.swift
//  IColab
//
//  Created by Kevin Dallian on 17/10/23.
//

import Foundation
import FirebaseFirestore

struct Request{
    var id = UUID().uuidString
    var worker : Account
    var role : Role
    var date : Date
    
    public func toDict() -> [String : Any] {
        return [
            "workerID" : self.worker.id,
            "role" : self.role.rawValue,
            "date" : Timestamp(date: self.date)
        ]
    }
}

enum RequestState {
    case notReviewed
    case approved
    case rejected
}
