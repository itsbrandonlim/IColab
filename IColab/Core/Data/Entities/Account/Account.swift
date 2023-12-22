//
//  Account.swift
//  IColab
//
//  Created by Kevin Dallian on 03/09/23.
//

import Foundation

class Account: Identifiable {
    var id : String
    var email : String
    var password : String
    
    var accountDetail : AccountDetail
    
    init(id: String = UUID().uuidString, email: String, password: String, accountDetail: AccountDetail, projectsOwned: [Project] = [], projectsJoined: [Project] = [], notifications: [Notification]? = nil, chats: [Chat]? = nil) {
        self.id = id
        self.email = email
        self.password = password
        self.accountDetail = accountDetail
    }
}

extension Account: Hashable{
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id &&
        lhs.email == rhs.email &&
        lhs.password == rhs.password
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(email)
        hasher.combine(password)
    }
}
