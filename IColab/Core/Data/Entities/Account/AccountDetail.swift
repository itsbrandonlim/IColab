//
//  AccountDetail.swift
//  IColab
//
//  Created by Kevin Dallian on 13/09/23.
//

import FirebaseFirestore
import Foundation

class AccountDetail: Identifiable, Equatable{
    @DocumentID var id: String?
    var name : String
    var desc : String
    var location : String
    var bankAccount : String
    var phoneNumber : String
    var skills : [String] = []
    var educations : [Education] = []
    var experiences : [Experience] = []
    
    var projectsOwned : [Project]
    var projectsJoined : [Project]
    var notifications : [Notification]?
    var chats: [Chat]?
    
    init(name: String, desc: String, location: String, bankAccount: String, phoneNumber: String, skills: [String] = [], educations: [Education] = [], experiences: [Experience] = [], projectsOwned: [Project] = [], projectsJoined: [Project] = [], notifications: [Notification] = [], chats: [Chat] = []) {
        self.name = name
        self.desc = desc
        self.location = location
        self.bankAccount = bankAccount
        self.phoneNumber = phoneNumber
        self.skills = skills
        self.educations = educations
        self.experiences = experiences
        self.projectsOwned = projectsOwned
        self.projectsJoined = projectsJoined
        self.notifications = notifications
        self.chats = chats
    }
    
    static func == (lhs: AccountDetail, rhs: AccountDetail) -> Bool {
        return lhs.id == rhs.id &&
        lhs.skills == rhs.skills &&
        lhs.educations == rhs.educations &&
        lhs.experiences == rhs.experiences
    }
    
    public func addExperiences(experience: Experience) {
        self.experiences.append(experience)
    }
    
    public func removeExperiences(idx: Int){
        self.experiences.remove(at: idx)
    }
    
    public func removeEducation(idx: Int){
        self.educations.remove(at: idx)
    }
    
    public func addEducation(education: Education) {
        self.educations.append(education)
    }
    
    public func removeSkill(idx: Int){
        self.skills.remove(at: idx)
    }
    
    public func toDict() -> [String: Any] {
        let detailConstants = FireStoreConstant.AccountDetailConstants()
        return [
            detailConstants.name : self.name,
            detailConstants.desc : self.desc,
            detailConstants.location : self.location,
            detailConstants.bankAccount : self.bankAccount,
            detailConstants.phoneNumber : self.phoneNumber,
            detailConstants.skills : self.skills,
            detailConstants.educations : self.educations.map({$0.toDict()}),
            detailConstants.experiences : self.experiences.map({$0.toDict()}),
            detailConstants.projectsOwned : self.projectsOwned.map({$0.id}),
            detailConstants.projectsJoined : self.projectsJoined.map({$0.id}),
            detailConstants.notifications : [Notification]()
        ]
    }
    
    static func decode(from data: [String : Any]) -> AccountDetail {
        let detailConstants = FireStoreConstant.AccountDetailConstants()
        let fetchProjectFromID = FetchDocumentFromIDUseCase()
        let name = data[detailConstants.name] as! String
        let phoneNumber = data[detailConstants.phoneNumber] as! String
        let bankAccount = data[detailConstants.bankAccount] as! String
        let desc = data[detailConstants.desc] as! String
        let location = data[detailConstants.location] as! String
        let skills = data[detailConstants.skills] as! [String]
        
        var educations : [Education] = []
        let educationsData = data[detailConstants.educations] as? [[String:Any]] ?? [[:]]
        educations = educationsData.map({Education.decode(from: $0)})
        var experiences : [Experience] = []
        let experiencesData = data[detailConstants.experiences] as? [[String:Any]] ?? [[:]]
        experiences = experiencesData.map({Experience.decode(from: $0)})
        
        let projectsJoinedData = (data[detailConstants.projectsJoined] as? [String] ?? [] )
        var projectsJoined = [Project]()
        projectsJoinedData.forEach { projectID in
            fetchProjectFromID.call(collectionName: "projects", id: projectID) { doc in
                if let document = doc.data() {
                    var project = Project.decode(from: document)
                    project.id = doc.documentID
                    projectsJoined.append(project)
                }
            }
        }
        
        let accountDetail = AccountDetail(name: name, desc: desc, location: location, bankAccount: bankAccount, phoneNumber: phoneNumber, skills: skills, educations: educations, experiences: experiences, projectsJoined: projectsJoined, notifications: [], chats: [])
        return accountDetail
    }
}
