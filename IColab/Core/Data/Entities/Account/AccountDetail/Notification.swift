//
//  Notification.swift
//  IColab
//
//  Created by Kevin Dallian on 18/09/23.
//

import FirebaseFirestore
import Foundation

struct Notification : Identifiable, Equatable {
    var id = UUID().uuidString
    var desc : String
    var projectName : String
    var date : Date
    var projectImage : String?
    
    static func decode(from data: [String:Any]) -> Notification {
        let description = data["description"] as! String
        let projectName = data["projectName"] as! String
        let date = (data["date"] as! Timestamp).dateValue()
        let projectImage = data["projectImage"] as? String
        return Notification(desc: description, projectName: projectName, date: date, projectImage: projectImage)
    }
    
    public func toDict() -> [String:Any]{
        return [
            "description" : self.desc,
            "projectName" : self.projectName,
            "date" : Timestamp(date: self.date),
            "projectImage" : self.projectImage
        ]
    }
}
