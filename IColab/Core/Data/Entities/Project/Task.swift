//
//  Task.swift
//  IColab
//
//  Created by Jeremy Raymond on 25/09/23.
//

import Foundation

struct Task: Identifiable, Equatable{
    var id = UUID().uuidString
    
    var title: String
    var status: TaskStatus = .notCompleted
    
    mutating func setStatus(status: TaskStatus) {
        self.status = status
    }
    
    public func toDict() -> [String: Any] {
        var dictionary : [String : Any] = [:]
        dictionary = [
            "title" : self.title,
            "status" : self.status.rawValue
        ]
        return dictionary
    }
    
    static func decode(from data: [String : Any]) -> Task {
        let title = data["title"] as! String
        let status = TaskStatus(rawValue: (data["status"] as! String))
        
        return Task(title: title, status: status!)
    }
}

enum TaskStatus: String, CaseIterable, Codable {
    case notCompleted = "Not Completed",
         onReview = "On Review",
         completed = "Completed"
}
