//
//  Message.swift
//  IColab
//
//  Created by Jeremy Raymond on 01/10/23.
//

import Foundation

struct Message: Identifiable, Equatable {
    var id: UUID = UUID()
    var text: String
    var time: Date
    var senderID : String
    
    static func decode(from data: [String : Any]) -> Message {
        let messageConstant = DatabaseConstant.MessageConstants()
        let text = data[messageConstant.text] as! String
        let time = Date(timeIntervalSince1970: data[messageConstant.time] as! TimeInterval)
        let senderID = data[messageConstant.senderID] as! String
        return Message(id: UUID(), text: text, time: time, senderID: senderID)
    }
    
    func toDict()-> [String:Any] {
        let messageConstant = DatabaseConstant.MessageConstants()
        return [
            messageConstant.text : self.text,
            messageConstant.time : self.time.timeIntervalSince1970,
            messageConstant.senderID : self.senderID
        ]
    }
}
