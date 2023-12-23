//
//  Chat.swift
//  IColab
//
//  Created by Jeremy Raymond on 01/10/23.
//

import Foundation

enum ChatType: String, CaseIterable, Codable {
    case personal = "personal"
    case owner = "owner"
    case group = "group"
}

struct Chat: Identifiable, Equatable, Searchable {
    var id: String
    
    var title: String
    var messages: [Message]
    var type: ChatType
    var members : [String : String]
    
    var projectName: String
    
    var isPinned: Bool
    
    init(id: String = UUID().uuidString, title: String, messages: [Message] = [], type: ChatType, members: [String:String] = [:], projectName: String, isPinned: Bool = false) {
        self.id = id
        self.title = title
        self.messages = messages
        self.type = type
        self.members = members
        self.projectName = projectName
        self.isPinned = isPinned
    }
    
    func toDict() -> [String:Any]{
        let chatConstants = DatabaseConstant.ChatConstants()
        return [
            chatConstants.title : self.title,
            chatConstants.projectName : self.projectName,
            chatConstants.type : self.type.rawValue,
            chatConstants.members : self.members
        ]
    }
    
    static func decode(from data: [String:Any]) -> Chat{
        let chatConstant = DatabaseConstant.ChatConstants()
        
        let title = data[chatConstant.title] as! String
        let projectName = data[chatConstant.projectName] as! String
        let type = ChatType(rawValue: data[chatConstant.type] as! String)
        let members = data[chatConstant.members] as! [String : String]
        
        return Chat(title: title, type: type!, members: members, projectName: projectName)
    }
}
