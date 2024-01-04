//
//  AccountManager.swift
//  IColab
//
//  Created by Kevin Dallian on 10/10/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class AccountManager : ObservableObject {
    static var shared = AccountManager()
    
    private init(){}

    @Published var account : Account?
    var fetch = FetchCollectionUseCase()
    var fetchDocument = FetchDocumentFromIDUseCase()
    var detailConstants = FireStoreConstant.AccountDetailConstants()
    
    public func getAccount(completion: @escaping ()-> Void) {
        
        if let user = Auth.auth().currentUser {
            fetchDocument.call(collectionName: detailConstants.collectionName, id: user.uid) { doc in
                if let document = doc.data(){
                    let accountDetail = AccountDetail.decode(from: document)
                    self.account = Account(id: user.uid, email: user.email!, password: "", accountDetail: accountDetail)
                    self.fetchOwnedProjects(ownerID: doc.documentID)
                    self.fetchJoinedProjects(projectIDs: document[self.detailConstants.projectsJoined] as? [String] ?? [])
                    completion()
                }
            }
        }
    }
    
    private func fetchOwnedProjects(ownerID: String){
        let fetchOwnedProject = FetchProjectsFromOwnerID()
        
        fetchOwnedProject.call(ownerID: ownerID) { result in
            switch result {
            case .success(let projects):
                projects.forEach { project in
                    if project.endDate <= Date.now {
                        project.projectState = .overdue
                    }
                    else if project.startDate <= Date.now {
                        project.projectState = .started
                    }
                    else {
                        project.projectState = .notStarted
                    }
                }
                self.account?.accountDetail.projectsOwned.append(contentsOf: projects)
            case .failure(_):
                self.account?.accountDetail.projectsOwned = []
            }
        }
    }
    
    private func fetchJoinedProjects(projectIDs: [String]) {
        let fetchJoinedProject = FetchDocumentFromIDUseCase()
        
        projectIDs.forEach { projectID in
            fetchJoinedProject.call(collectionName: "projects", id: projectID) { doc in
                if let document = doc.data() {
                    let project = Project.decode(from: document)
                    project.id = doc.documentID
                    if project.endDate <= Date.now {
                        project.projectState = .overdue
                    }
                    else if project.startDate <= Date.now {
                        project.projectState = .started
                    }
                    else {
                        project.projectState = .notStarted
                    }
                    self.account?.accountDetail.projectsJoined.append(project)
                }
            }
        }
    }
    
    public func setAccount(account: Account) {
        self.account = account
        self.objectWillChange.send()
    }
    
    public func logout(){
        account = nil
        AuthenticationManager.shared.logoutUser()
        self.objectWillChange.send()
    }
}
