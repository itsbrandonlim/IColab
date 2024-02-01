//
//  FireStoreConstant.swift
//  IColab
//
//  Created by Kevin Dallian on 08/12/23.
//

import Foundation

struct FireStoreConstant {
    struct AccountDetailConstants {
        let collectionName = "accountDetails"
        let accountID = "accountID"
        let bankAccount = "bankAccount"
        let desc = "desc"
        let location = "location"
        let name = "name"
        let phoneNumber = "phoneNumber"
        let skills = "skills"
        let educations = "educations"
        let experiences = "experiences"
        let projectsOwned = "projectsOwned"
        let projectsJoined = "projectsJoined"
        let notifications = "notifications"
        let chats = "chats"
    }
    
    struct ProjectConstants {
        let collectionName = "projects"
        let id = "id"
        let title = "title"
        let desc = "desc"
        let endDate = "endDate"
        let members = "members"
        let milestones = "milestones"
        let ownerID = "ownerID"
        let projectState = "projectState"
        let request = "request"
        let requirements = "requirements"
        let role = "role"
        let startDate = "startDate"
        let tags = "tags"
    }
    
    struct PaymentConstants {
        let collectionName = "payments"
        let id = "id"
        let amount = "amount"
        let isValidated = "isValidated"
        let ownerId = "ownerid"
        let workerId = "workerid"
        let projectId = "projectid"
        let goalid = "goalid"
    }
}

var accountDetail = FireStoreConstant.AccountDetailConstants()
var notifications = accountDetail.notifications

