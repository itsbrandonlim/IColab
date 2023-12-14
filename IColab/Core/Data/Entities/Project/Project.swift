//
//  Project.swift
//  IColab
//
//  Created by Kevin Dallian on 02/09/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class Project : Identifiable, Searchable{
    var id : String
    var title : String
    var owner : String?
    var members: [Member]?
    var role : String
    var requirements : [String]
    var tags : [String]
    var startDate : Date
    var endDate : Date
    var desc : String
    var milestones : [Milestone]
    var requests : [Request] = []
    var projectState : ProjectState

    init(id: String = UUID().uuidString, title: String, owner: String? = nil, members: [Member]? = [], role: String, requirements: [String] = [], tags: [String] = [], startDate: Date, endDate: Date, desc: String, milestones: [Milestone], projectState: ProjectState = .notStarted) {
        self.id = id
        self.title = title
        self.owner = owner
        self.members = members
        self.role = role
        self.requirements = requirements
        self.tags = tags
        self.startDate = startDate
        self.endDate = endDate
        self.desc = desc
        self.milestones = milestones
        self.projectState = projectState
    }
    
    func setOverview(title: String, tags: [String], desc: String) {
        self.title = title
        self.tags = tags
        self.desc = desc
    }
    
    public func setOwner(owner : String){
        self.owner = owner
    }
    
    public func totalMilestone() -> Int{
        var total = 0
        for milestone in milestones {
            total += milestone.goals[0].nominal
        }
        return total
    }
    
    public func calculateAverageMilestone() -> Float {
        return Float(totalMilestone()/milestones.count)
    }
    
    public func addMilestone(milestone : Milestone){
        milestones.append(milestone)
    }
    
    public func toDict() -> [String: Any] {
        var dictionary = [String: Any]()
        var projectConstants = FireStoreConstant.ProjectConstants()
        dictionary = [
            projectConstants.title : self.title,
            projectConstants.ownerID : self.owner,
            projectConstants.members : [],
            projectConstants.role : self.role,
            projectConstants.requirements : self.requirements,
            projectConstants.tags : self.tags,
            projectConstants.startDate: Timestamp(date: self.startDate),
            projectConstants.endDate : Timestamp(date: self.endDate),
            projectConstants.desc : self.desc,
            projectConstants.milestones : self.milestones.map({$0.toDict()}),
            projectConstants.request : self.requests,
            projectConstants.projectState : self.projectState.rawValue
        ]
        return dictionary
    }
    
    static func decode(from data: [String : Any]) -> Project {
        var projectConstants = FireStoreConstant.ProjectConstants()
        let title = data[projectConstants.title] as! String
        let ownerID = data[projectConstants.ownerID] as! String
        let members = (data[projectConstants.members] as? [[String:Any]] ?? []).map({Member.decode(from: $0)})
        let role = data[projectConstants.role] as! String
        let requirements = data[projectConstants.requirements] as! [String]
        let tags = data[projectConstants.tags] as! [String]
        
        let startDateData = data[projectConstants.startDate] as! Timestamp
        let startDate = startDateData.dateValue()
        
        let endDateData = data[projectConstants.endDate] as! Timestamp
        let endDate = endDateData.dateValue()
        
        let desc = data[projectConstants.desc] as! String
        let milestones = (data[projectConstants.milestones] as? [[String:Any]] ?? []).map({Milestone.decode(from: $0)})
        let projectState = ProjectState(rawValue: (data[projectConstants.projectState] as! String))
        return Project(title: title, owner: ownerID, members: members, role: role, requirements: requirements, tags: tags, startDate: startDate, endDate: endDate, desc: desc, milestones: milestones, projectState: projectState!)
    }
}

extension Project: Hashable{
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.owner == rhs.owner &&
        lhs.role == rhs.role &&
        lhs.requirements == rhs.requirements &&
        lhs.tags == rhs.tags &&
        lhs.startDate == rhs.startDate &&
        lhs.endDate == rhs.endDate &&
        lhs.desc == rhs.desc &&
        lhs.milestones == rhs.milestones
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(owner)
        hasher.combine(role)
        hasher.combine(requirements)
        hasher.combine(tags)
        hasher.combine(startDate)
        hasher.combine(endDate)
        hasher.combine(desc)
        hasher.combine(milestones)
    }
}
