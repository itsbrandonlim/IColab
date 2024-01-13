//
//  ProjectOverviewViewModel.swift
//  IColab
//
//  Created by Jeremy Raymond on 26/09/23.
//

import Foundation

class ProjectOverviewViewModel: ObservableObject {
    @Published var project: Project = Mock.projects[0]
    @Published var requestAccount : AccountDetail!
    @Published var selectedRole : Role!
    var fetchAccount = FetchDocumentFromIDUseCase()
    var updateProject = UpdateProjectUseCase()
    var updateAccountDetail = AddAccountDetailUseCase()
    var accountDetailConstants = FireStoreConstant.AccountDetailConstants()
    
    init(project : Project) {
        self.project = project
        selectedRole = project.milestones.first!.role
    }
    
    func editProjectDetail(title: String, summary: String, tags: [String], startDate: Date, endDate: Date) {
        self.project.setOverview(title: title, tags: tags, desc: summary, startDate: startDate, endDate: endDate)
        saveProjecttoFireStore()
    }
    
    func getCurrentGoal() -> Goal {
        guard let selectedRoleGoals = self.project.milestones.first(where: {$0.role == selectedRole})?.goals else {
            return self.project.milestones[0].goals[0]
        }
        
        return selectedRoleGoals.first(where: {!$0.isAchieved}) ?? selectedRoleGoals[0]
    }
    
    func getExistingRoles() -> [Role] {
        var roles: [Role] = []
        for role in Role.allCases {
            if getMemberCount(role: role) != 0 {
                roles.append(role)
            }
        }
        return roles
    }
    
    func getMemberCount(role: Role) -> Int {
        var count: Int = 0
        
        for member in self.project.members {
            if member.role == role {
                count += 1;
            }
        }
        
        return count
    }
    
    func fetchOwner(ownerID: String){
        fetchAccount.call(collectionName: "accountDetails", id: ownerID) { doc in
            if let document = doc.data() {
                self.requestAccount = AccountDetail.decode(from: document)
            }
        }
    }
    
    func rejectRequest(request: Request){
        self.deleteRequest(request: request)
        self.saveProjecttoFireStore()
        fetchAccount.call(collectionName: accountDetailConstants.collectionName, id: request.workerID) { document in
            if let doc = document.data() {
                var accountDetail = AccountDetail.decode(from: doc)
                accountDetail.id = document.documentID
                accountDetail.notifications.append(Notification(desc: "Request Rejected", projectName: self.project.title, date: Date.now))
                self.updateAccountDetail.call(accountDetail: accountDetail, id: request.workerID) { error in
                    if let error = error {
                        print("Error updating account detail to firebase : \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func acceptRequest(request : Request){
        let member = Member(workerID: request.workerID, role: request.role)
        self.project.members.append(member)
        self.deleteRequest(request: request)
        fetchAccount.call(collectionName: accountDetailConstants.collectionName, id: request.workerID) { document in
            if let doc = document.data() {
                let accountDetail = AccountDetail.decode(from: doc)
                accountDetail.id = document.documentID
                accountDetail.projectsJoined.append(self.project)
                accountDetail.notifications.append(Notification(desc: "Request Accepted", projectName: self.project.title, date: Date.now))
                
                self.updateAccountDetail.call(accountDetail: accountDetail, id: request.workerID) { error in
                    if let error = error {
                        print("Error updating account detail to firebase : \(error.localizedDescription)")
                    }
                }
            }
        }
        self.saveProjecttoFireStore()
    }
    
    func deleteRequest(request : Request){
        guard let index = project.requests.firstIndex(where: {$0.id == request.id}) else {
            return
        }
        project.requests.remove(at: index)
        
        self.objectWillChange.send()
    }
    
    func extendProject(startDate : Date, endDate : Date){
        project.startDate = startDate
        project.endDate = endDate
        
        project.projectState = .extended
        saveProjecttoFireStore()
        self.objectWillChange.send()
    }
    
    private func saveProjecttoFireStore(){
        updateProject.call(project: project) { error in
            if let error = error {
                print("Error updating Project : \(error.localizedDescription)")
            }
        }
    }
}
