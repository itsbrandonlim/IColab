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
    
    static func getTabs(userId: String) -> [TabBarType] {
        let checkAdmin = FetchDocumentFromIDUseCase()
        
        var tabBars: [TabBarType] = []
        checkAdmin.call(collectionName: "users", id: userId) { doc in
            if doc.exists {
                tabBars = [.home, .payment, .user]
            }
            else {
                tabBars = [.home, .projects, .chats, .notifications, .profile]
            }
        }
        print("Done")
        
        return tabBars
    }
    
//    static func getTabs(userId: String) -> [TabBarType] {
//        var checkAdmin = CheckAdminUseCase()
//        print("authentichaed id is: \(userId)")
//        
//        if checkAdmin.call(userId: userId) {
//            return [.home, .payment, .user]
//        }
//        else {
//            return [.home, .projects, .chats, .notifications, .profile]
//        }
//    }
    
    static func getUserTabs() -> [TabBarType] {
        return [.home, .projects, .chats, .notifications, .profile]
    }
    
    static func getAdminTabs() -> [TabBarType] {
        return [.home, .payment, .user, .profile]
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
