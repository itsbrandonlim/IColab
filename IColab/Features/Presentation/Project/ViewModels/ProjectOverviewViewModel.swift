//
//  ProjectOverviewViewModel.swift
//  IColab
//
//  Created by Jeremy Raymond on 26/09/23.
//

import Foundation

class ProjectOverviewViewModel: ObservableObject {
    @Published var project: Project = Mock.projects[0]
    var fetchAccount = FetchDocumentFromIDUseCase()
    var updateProject = UpdateProjectUseCase()
    var updateAccountDetail = AddAccountDetailUseCase()
    var accountDetailConstants = FireStoreConstant.AccountDetailConstants()
    
    init(project : Project) {
        self.project = project
    }
    func getProject(uid: String) -> Project {
        let project = Mock.projects.first(where: {$0.id == uid})
        return project!
    }
    
    func editProjectDetail(title: String, summary: String, tags: [String]) {
        self.project.setOverview(title: title, tags: tags, desc: summary)
    }
    
    func getCurrentGoal() -> Goal {
        let goals = self.project.milestones[0].goals
        
        for goal in goals {
            if !goal.isAchieved {
                return goal
            }
        }
        
        return goals[0]
    }
    
    func existingRoles() -> [Role] {
        var roles: [Role] = []
        for role in Role.allCases {
            if memberCount(role: role) != 0 {
                roles.append(role)
            }
        }
        return roles
    }
    
    func memberCount(role: Role) -> Int {
        var count: Int = 0
        
        for member in self.project.members {
            if member.role == role {
                count += 1;
            }
        }
        
        return count
    }
    
    func rejectRequest(request: Request){
        fetchAccount.call(collectionName: accountDetailConstants.collectionName, id: request.workerID) { document in
            if let doc = document.data() {
                let accountDetail = AccountDetail.decode(from: doc)
                accountDetail.notifications?.append(Notification(desc: "Request Rejected", projectName: self.project.title, date: Date.now))
                self.deleteRequest(request: request)
            }
        }
    }
    
    func acceptRequest(request : Request){
        let member = Member(workerID: request.workerID, role: request.role)
        self.project.members.append(member)
        self.deleteRequest(request: request)
        
        self.saveProjecttoFireStore()
        
        fetchAccount.call(collectionName: accountDetailConstants.collectionName, id: request.workerID) { workerDoc in
            if let worker = workerDoc.data() {
                var workerAccountDetail = AccountDetail.decode(from: worker)
                workerAccountDetail.projectsJoined.append(self.project)
                self.updateAccountDetail.call(accountDetail: workerAccountDetail, id: workerDoc.documentID) { error in
                    if let error = error {
                        print("Error Updating Worker Detail : \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func deleteRequest(request : Request){
        guard let index = project.requests.firstIndex(where: {$0.id == request.id}) else {
            return
        }
        project.requests.remove(at: index)
        
        self.objectWillChange.send()
    }
    
    func extend(date : Date){
        let dateRange = Calendar.current.dateComponents([.day], from: project.startDate, to: project.endDate)
        project.startDate = date
        project.endDate = Calendar.current.date(byAdding: dateRange, to: date)!
        
        project.projectState = .extended
        self.objectWillChange.send()
    }
    
    private func saveProjecttoFireStore(){
        updateProject.call(project: project) { error in
            if let error = error {
                print("Error updating Project : \(error.localizedDescription)")
            }
        }
        
        // save owner account
        fetchAccount.call(collectionName: accountDetailConstants.collectionName, id: project.owner!) { ownerDoc in
            if let owner = ownerDoc.data() {
                var ownerDetail = AccountDetail.decode(from: owner)
                
                guard let projectIndex = ownerDetail.projectsOwned.firstIndex(of: self.project) else {
                    return
                }
                ownerDetail.projectsOwned[projectIndex] = self.project
                self.updateAccountDetail.call(accountDetail: ownerDetail, id: ownerDoc.documentID) { error in
                    if let error = error {
                        print("Error Updating Owner's Account Detail : \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
