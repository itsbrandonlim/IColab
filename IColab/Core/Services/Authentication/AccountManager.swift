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
        let fetchOwnedProject = FetchProjectsFromOwnerID()
        if let user = Auth.auth().currentUser {
            fetchDocument.call(collectionName: detailConstants.collectionName, id: user.uid) { doc in
                if let document = doc.data(){
                    var accountDetail = AccountDetail.decode(from: document)
                    fetchOwnedProject.call(ownerID: doc.documentID) { result in
                        switch result {
                        case .success(let projects):
                            accountDetail.projectsOwned.append(contentsOf: projects)
                        case .failure(let error):
                            accountDetail.projectsOwned = []
                        }
                    }
                    self.account = Account(id: user.uid, email: user.email!, password: "", accountDetail: accountDetail)
                    completion()
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
