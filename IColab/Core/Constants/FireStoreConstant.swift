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
        let desc = "description"
        let location = "location"
        let name = "name"
        let phoneNumber = "phoneNumber"
        let skills = "skills"
    }
    
    struct ProjectConstants {
        let collectionName = "projects"
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
}
