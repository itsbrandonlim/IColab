//
//  ProjectMainViewModel.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 10/2/23.
//

import Foundation

enum ProjectMainViewPicker: String, CaseIterable {
    case projectOwned = "Project Owned"
    case projectJoined = "Project Joined"
}

class ProjectMainViewModel: ObservableObject {
    @Published var account: Account = Mock.accounts[0]
    @Published var projectJoined: [Project] = []
    @Published var projectOwned: [Project] = []
    
    @Published var picker: ProjectMainViewPicker = .projectOwned
    @Published var needRefresh : Bool = false
    
    init(){
        self.account = getAccount()
        self.projectJoined = account.accountDetail.projectsJoined
        self.projectOwned = account.accountDetail.projectsOwned
    }
    
    private func getAccount() -> Account{
        return AccountManager.shared.account!
    }
    
    func getProjectsByType(picker: ProjectMainViewPicker) -> [Project] {
        switch picker {
            case .projectOwned:
            return account.accountDetail.projectsOwned
            case .projectJoined:
            return account.accountDetail.projectsJoined
        }
    }
}
