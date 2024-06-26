//
//  Goal.swift
//  IColab
//
//  Created by Jeremy Raymond on 01/10/23.
//

import Foundation
import FirebaseFirestore

struct Goal: Identifiable, Equatable{
    let id = UUID().uuidString
    var name : String
    var nominal : Int
    var desc : String
    var endDate : Date
    var isAchieved : Bool
    var tasks: [Task]
    
    mutating func setTask(task: Task, index: Int) {
        self.tasks[index] = task
    }
    
    init(name: String, nominal: Int, desc : String, endDate: Date, isAchieved: Bool, tasks: [Task]){
        self.name = name
        self.nominal = nominal
        self.desc = desc
        self.endDate = endDate
        self.isAchieved = isAchieved
        self.tasks = tasks
    }
    
    public func toDict() -> [String : Any] {
        return [
            "name" : self.name,
            "nominal" : self.nominal,
            "desc" : self.desc,
            "endDate" : Timestamp(date: self.endDate),
            "isAchieved" : self.isAchieved,
            "tasks" : self.tasks.map({$0.toDict()})
        ]
    }
    
    static func decode(from data: [String:Any]) -> Goal {
        let name = data["name"] as! String
        let nominal = data["nominal"] as! Int
        let desc = data["desc"] as! String
        let endDate = (data["endDate"] as! Timestamp).dateValue()
        let isAchieved = data["isAchieved"] as! Bool
        let tasks = (data["tasks"] as? [[String:Any]] ?? []).map({Task.decode(from: $0)})
        
        return Goal(name: name, nominal: nominal, desc: desc, endDate: endDate, isAchieved: isAchieved, tasks: tasks)
    }
    
    func getProgress() -> Double{
        return Double(tasks.filter({$0.status == .completed}).count) / Double(tasks.count)
    }

}
