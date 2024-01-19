//
//  TabBarType.swift
//  IColab
//
//  Created by Kevin Dallian on 02/09/23.
//

import Foundation

enum TabBarType {
    case home
    case projects
    case chats
    case notifications
    case profile
    
    case payment
    case user
    
    static func getUserTabs() -> [TabBarType] {
        return [.home, .projects, .chats, .notifications, .profile]
    }
    
    static func getAdminTabs() -> [TabBarType] {
        return [.home, .payment, .user]
    }
}

extension TabBarType{
    func getImage() -> String{
        switch self{
        case .home:
            return "doc.text.magnifyingglass"
        case .projects:
            return "menucard"
        case .chats:
            return "bubble.left"
        case .notifications:
            return "bell"
        case .profile:
            return "person"
        case .payment:
            return "dollarsign"
        case .user:
            return "person"
        }
    }
    func getCaption() -> String {
        switch self{
        case .home:
            return "Browse"
        case .projects:
            return "Projects"
        case .chats:
            return "Chats"
        case .notifications:
            return "Notifications"
        case .profile:
            return "Profile"
        case .payment:
            return "Payment"
        case .user:
            return "User"
        }
    }
}
