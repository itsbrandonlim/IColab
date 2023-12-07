//
//  LoginViewModel.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 10/2/23.
//

import Foundation
import SwiftUI

enum LoginError : LocalizedError{
    case invalidPassword
    case incompleteForm
    
    
    var errorDescription: String {
        switch self {
        case .invalidPassword:
            return "Invalid Username or Password"
        case .incompleteForm:
            return "Username or Password is empty"
        }
    }
    
    var errorSuggestion : String {
        switch self {
        case .invalidPassword:
            return "Try filling the right username or password."
        case .incompleteForm:
            return "Cannot login when username or password is empty."
        }
    }
}

class LoginViewModel: ObservableObject {
    @Published var email : String
    @Published var password : String
    @Published var error : LoginError?
    @Published var showAlert : Bool
    @Published var createAccount : Bool
    @Binding var showSignIn : Bool
    
    init(email: String = "", password: String = "", error: LoginError? = nil, showAlert: Bool = false, createAccount: Bool = false, showSignIn: Binding<Bool>) {
        self.email = email
        self.password = password
        self.error = error
        self.showAlert = showAlert
        self.createAccount = createAccount
        self._showSignIn = showSignIn
    }
    
    public func login(){
        let getEmail = email
        let getPassword = password
        
        if getEmail.isEmpty || getPassword.isEmpty {
            error = .incompleteForm
            showAlert = true
            return
        }
        
        AuthenticationManager.shared.loginUser(email: self.email, password: self.password) { authDataResult, error in
            if let error = error {
                print(error)
            }
            if let result = authDataResult {
                let accountDetail = AccountDetail(name: result.user.displayName!, desc: "", location: "", bankAccount: "", cvLink: "")
                let account = Account(email: result.user.email!, password: self.password, accountDetail: accountDetail)
                AccountManager.shared.setAccount(account: account)
                self.showSignIn = false
                print("Login Success")
            }
        }
    }
}
