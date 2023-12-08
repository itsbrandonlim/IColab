//
//  AccountManager.swift
//  IColab
//
//  Created by Kevin Dallian on 10/10/23.
//

import Foundation

class AccountManager : ObservableObject {
    static var shared = AccountManager()
    
    private init(){}

    @Published var account : Account?
    
    public func getAccount(uid: String) {
        if let foundAccount = Mock.accounts.first(where: { account in
            account.id == uid
        }) {
            account = foundAccount
            self.objectWillChange.send()
        }else{
            print("Account not found")
        }
    }
    
    public func setAccount(account: Account) {
        self.account = account
        self.objectWillChange.send()
    }
    
    public func logout(){
        account = nil
        self.objectWillChange.send()
    }
}