//
//  DatabaseConstant.swift
//  IColab
//
//  Created by Kevin Dallian on 23/12/23.
//

import Foundation

struct DatabaseConstant {
    static let databaseReferenceURL = "https://icolab-cdaf2-default-rtdb.asia-southeast1.firebasedatabase.app"
    struct ChatConstants {
        let parentName = "Chats"
        let title = "title"
        let type = "type"
        let members = "members"
        let projectName = "projectName"
    }
    
    struct MessageConstants {
        let parentName = "Messages"
        let text = "text"
        let time = "timeStamp"
        let senderID = "senderID"
    }
}
