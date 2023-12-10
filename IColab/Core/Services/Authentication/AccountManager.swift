//
//  AccountManager.swift
//  IColab
//
//  Created by Kevin Dallian on 10/10/23.
//

import FirebaseAuth
import Foundation

class AccountManager : ObservableObject {
    static var shared = AccountManager()
    
    private init(){}

    @Published var account : Account?
    var fetch = FetchCollectionUseCase()
    var fetchDocument = FetchDocumentFromIDUseCase()
    var accountDetailConstants = FireStoreConstant.AccountDetailConstants()
    
    public func getAccount() {
        if let user = Auth.auth().currentUser {
            fetchDocument.call(collectionName: accountDetailConstants.collectionName, id: user.uid) { doc in
                do {
                    let accountDetail = try doc.data(as: AccountDetail.self)
                    self.account = Account(email: user.email!, password: "", accountDetail: accountDetail)
                } catch let error {
                    print("Error parsing account Detail : \(error.localizedDescription)")
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
