//
//  CreateProjectViewModel.swift
//  IColab
//
//  Created by Jeremy Raymond on 10/10/23.
//

import Foundation
import SwiftUI

class CreateProjectViewModel: ObservableObject {
    @Published var account: Account!
    @Published var project: Project = Project(title: "", role: "", requirements: [], tags: [], startDate: Date.now, endDate: Date.now, desc: "Short Summary", milestones: [])
    @Published var error: CreateProjectError?
    @Binding var needRefresh : Bool
    @Published var showAlert : Bool = false
    var addProject = AddProjectUseCase()
    var projectConstants = FireStoreConstant.ProjectConstants()
    var updateAccountDetail = AddAccountDetailUseCase()
    
    init(needRefresh: Binding<Bool>){
        self._needRefresh = needRefresh
        self.account = getAccount()
        project.owner = account.id
    }
    
    private func getAccount() -> Account{
        return AccountManager.shared.account!
    }
    
    func createProject() -> Bool {
        if validateProjectMilestones() {
            project.members = []
            self.account.accountDetail.projectsOwned.append(self.project)
            do {
                try addProject.call(collectionName: projectConstants.collectionName, element: project)
            } catch let error {
                print("Error adding data to firestore : \(error.localizedDescription)")
            }
            updateAccountDetail.call(accountDetail: self.account.accountDetail, id: account.id) { error in
                if let error = error {
                    self.showError(error: .firestoreError(error))
                }
            }
            if showAlert {
                return false
            }
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
        let milestonesThatHasNoGoal = project.milestones.filter({$0.goals.isEmpty})
        if !milestonesThatHasNoGoal.isEmpty {
            showError(error: .goalsMissing(milestonesThatHasNoGoal.first!))
        }
        let goalsThatHasNoTask = project.milestones.flatMap({$0.goals}).filter({$0.tasks.isEmpty})
        if !goalsThatHasNoTask.isEmpty {
            showError(error: .taskMissing(goalsThatHasNoTask.first!))
        }
        return true
    }
}
