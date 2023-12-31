//
//  Mock.swift
//  IColab
//
//  Created by Kevin Dallian on 02/09/23.
//

import Foundation

struct Mock {
    static var projects: [Project] = []
    static var chats: [Chat] = []
    static var notifications: [Notification] = []
    static var accounts: [Account] = []
    
    static var tags: [String] = ["SwiftUI", "UIKit", "Vision", "SpriteKit", "CoreML", "AVFoundation"]
    
    init() {
        Mock.accounts = MockAccounts.array
        Mock.projects = MockProjects.array
        Mock.notifications = MockNotifications.array
        Mock.chats = MockChats.generateArray()
        for account in Mock.accounts {
            account.projectsOwned = MockProjects.generateArray()
            account.projectsJoined = MockProjects.generateArray()
            account.chats = Mock.chats
            account.notifications = Mock.notifications
        }
    }
}
