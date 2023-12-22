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
    @Published var roles: [Role] = []
    @Published var error: CreateProjectError?
    @Binding var needRefresh : Bool
    @Published var showAlert : Bool = false
    var addDatatoFireStore = AddDatatoFireStoreUseCase()
    var projectConstants = FireStoreConstant.ProjectConstants()
    var updateAccountDetail = AddAccountDetailUseCase()
    
    init(needRefresh: Binding<Bool>){
        self._needRefresh = needRefresh
        self.account = getAccount()
    }
    
    private func getAccount() -> Account{
        return AccountManager.shared.account!
    }
    
    func createProject() -> Bool {
        if validateProjectMilestones() {
            project.owner = account.id
            project.members = []
            self.account.accountDetail.projectsOwned.append(self.project)
            do{
                try addDatatoFireStore.call(collectionName: projectConstants.collectionName, element: project)
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
        return true
    }
}
