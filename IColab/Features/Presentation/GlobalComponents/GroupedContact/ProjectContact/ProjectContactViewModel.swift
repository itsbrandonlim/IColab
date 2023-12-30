//
//  ProjectContactViewModel.swift
//  IColab
//
//  Created by Kevin Dallian on 18/12/23.
//

import Foundation

class ProjectContactViewModel : ObservableObject {
    @Published var members: [AccountDetail]
    @Published var project : Project
    @Published var owner : AccountDetail!
    @Published var isLoading : Bool = false
    var fetchAccounts = FetchCollectionUseCase()
    var accountDetailConstants = FireStoreConstant.AccountDetailConstants()
    var fetchOwnerUseCase = FetchDocumentFromIDUseCase()
    
    init(project : Project){
        self.isLoading = true
        self.project = project
        self.members = []
        fetchOwner(ownerID: project.owner!)
        fetchMembers()
    }
    
    func fetchMembers() {
        fetchAccounts.call(collectionName: accountDetailConstants.collectionName) { qss in
            qss.documents.forEach { doc in
                self.project.members.forEach { member in
                    if doc.documentID == member.workerID {
                        self.members.append(AccountDetail.decode(from: doc.data()))
                    }
                }
                self.isLoading = false
            }
        }
    }
    
    func fetchOwner(ownerID: String) {
        fetchOwnerUseCase.call(collectionName: accountDetailConstants.collectionName, id: ownerID) { doc in
            if let data = doc.data() {
                self.owner = AccountDetail.decode(from: data)
            }
        }
    }
}
