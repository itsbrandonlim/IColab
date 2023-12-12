//
//  CreateProjectViewModel.swift
//  IColab
//
//  Created by Jeremy Raymond on 10/10/23.
//

import Foundation
import SwiftUI

class CreateProjectViewModel: ObservableObject {
    @Published var account: Account = Mock.accounts[0]
    @Published var project: Project = Project(title: "", role: "", requirements: [], tags: [], startDate: Date.now, endDate: Date.now, desc: "Short Summary", milestones: [])
    @Published var roles: [Role] = []
    @Published var error: CreateProjectError?
    @Binding var needRefresh : Bool
    @Published var showAlert : Bool = false
    
    init(needRefresh: Binding<Bool>){
        self._needRefresh = needRefresh
        self.account = getAccount()
    }
    
    private func getAccount() -> Account{
        return AccountManager.shared.account!
    }
    
    func createProject()-> Bool {
        if validateProjectMilestones() {
            project.owner = account
            project.members = []
            
            Mock.projects.append(self.project)
            self.account.projectsOwned.append(self.project)
            self.needRefresh.toggle()
            self.objectWillChange.send()
            return true
        }
        return false
    }
    
    func showError(error: CreateProjectError){
        self.error = error
        self.showAlert = true
    }
    
    func validateProjectDetail() -> Bool{
        if project.title == "" {
            showError(error: .titleMissing)
            return false
        }else if project.desc == "" {
            showError(error: .summaryMissing)
            return false
        }
        return true
    }
    
    func validateProjectMilestones() -> Bool {
        if project.milestones.isEmpty {
            showError(error: .milestoneMissing)
            return false
        }
        return true
    }
}
