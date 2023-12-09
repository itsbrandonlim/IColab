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
    var accountDetailConstants = FireStoreConstant.AccountDetailConstants()
    
    public func getAccount() {
        if let user = Auth.auth().currentUser {
            fetch.call(collectionName: "accountDetails") { querySnapShot, error in
                if let error = error {
                    print("Error fetching collection : \(error.localizedDescription)")
                }
                guard let qss = querySnapShot else {
                    return
                }
                qss.documents.forEach { doc in
                    if doc.data()[self.accountDetailConstants.accountID] as? String == user.uid {
                        do{
                            let accountDetail = try doc.data(as: AccountDetail.self)
                            self.account = Account(email: user.email!, password: "", accountDetail: accountDetail)
                        } catch let error {
                            print("Error parsing account detail : \(error.localizedDescription)")
                        }
                    }
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
