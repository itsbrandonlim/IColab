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
        var detailConstants = FireStoreConstant.AccountDetailConstants()
        return [
            detailConstants.name : self.name,
            detailConstants.desc : self.desc,
            detailConstants.location : self.location,
            detailConstants.bankAccount : self.bankAccount,
            detailConstants.phoneNumber : self.phoneNumber,
            detailConstants.skills : self.skills,
            detailConstants.educations : self.educations,
            detailConstants.experiences : self.experiences
        ]
    }
}
