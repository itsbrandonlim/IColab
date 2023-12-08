//
//  LoginViewModel.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 10/2/23.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email : String
    @Published var password : String
    @Published var error : LoginError?
    @Published var showAlert : Bool
    @Published var createAccount : Bool
    @Binding var showSignIn : Bool
    @Published var isLoading : Bool
    
    init(email: String = "", password: String = "", error: LoginError? = nil, showAlert: Bool = false, createAccount: Bool = false, showSignIn: Binding<Bool>) {
        self.email = email
        self.password = password
        self.error = error
        self.showAlert = showAlert
        self.createAccount = createAccount
        self._showSignIn = showSignIn
        self.isLoading = false
    }
    
    public func login(){
        self.isLoading = true
        let getEmail = email
        let getPassword = password
        
        if getEmail.isEmpty || getPassword.isEmpty {
            error = .incompleteForm
            showAlert = true
            self.isLoading = false
            return
        }
        
        AuthenticationManager.shared.loginUser(email: self.email, password: self.password) { authDataResult, error in
            if let error = error {
                self.error = .firebaseError(error)
                self.showAlert = true
                self.isLoading = false
            }
            if let result = authDataResult {
                let accountDetail = AccountDetail(name: result.user.displayName!, desc: "", location: "", bankAccount: "", cvLink: "")
                let account = Account(email: result.user.email!, password: self.password, accountDetail: accountDetail)
                AccountManager.shared.setAccount(account: account)
                self.isLoading = false
                self.showSignIn = false
            }
        }
    }
}
