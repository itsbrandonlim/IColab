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
    var fetchAccounts = FetchCollectionUseCase()
    var accountDetailConstants = FireStoreConstant.AccountDetailConstants()
    
    init(project : Project){
        self.project = project
        self.members = []
    }
    
    func fetchMembers() {
        fetchAccounts.call(collectionName: accountDetailConstants.collectionName) { qss in
            qss.documents.forEach { doc in
                self.project.members.forEach { member in
                    if doc.documentID == member.workerID {
                        self.members.append(AccountDetail.decode(from: doc.data()))
                    }
                }
            }
        }
    }
}
