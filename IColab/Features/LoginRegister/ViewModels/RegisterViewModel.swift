//
//  RegisterViewModel.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 10/2/23.
//

import SwiftUI
import Foundation
import FirebaseAuth



class RegisterViewModel : ObservableObject {
    @Published var username : String
    @Published var email : String
    @Published var password : String
    @Published var phoneNumber : String
    @Published var region : String
    @Published var signIn = false
    @Binding var showSignIn : Bool
    
    @Published var error : RegisterError?
    @Published var showError : Bool
    
    init(username: String = "", email: String = "", password: String = "", phoneNumber: String = "", region: String = "", signIn: Bool = false, showSignIn: Binding<Bool>, error: RegisterError? = nil, showError: Bool = false) {
        self.username = username
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.region = region
        self.signIn = signIn
        self._showSignIn = showSignIn
        self.error = error
        self.showError = showError
    }
    
    public func register(){
        if registrationValidation() {
            AuthenticationManager.shared.createUser(email: self.email, password: self.password) { authDataResult, error in
                if let error = error {
                    self.showError(error: .firebaseError(error))
                }else{
                    let profileChangeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    profileChangeRequest?.displayName = self.username
                    profileChangeRequest?.commitChanges(completion: { error in
                        if let error = error {
                            self.showError(error: .firebaseError(error))
                        }else if let result = authDataResult{
                            let accountDetail = AccountDetail(name: result.user.displayName!, desc: "", location: self.region, bankAccount: "", cvLink: "")
                            let account = Account(email: result.user.email!, password: self.password, accountDetail: accountDetail)
                            Mock.accounts.append(account)
                            AccountManager.shared.getAccount(uid: account.id)
                            self.showSignIn = false
                        }
                    })
                }
            }
        }
    }
    
    private func registrationValidation() -> Bool {
        if username.isEmpty || email.isEmpty || password.isEmpty || phoneNumber.isEmpty || region.isEmpty {
            showError(error: .formIncomplete)
            return false
        }
        
        if username.count < 8 {
            showError(error: .shortUsername)
            return false
        }
        
        if password.count < 8 {
            showError(error: .passwordLessThan8)
            return false
        }
        
        if !email.contains("@") {
            showError(error: .notEmailFormat)
            return false
        }
        
        if let double = Double(phoneNumber) {
            print("The string is numeric: \(double)")
        }else{
            showError(error: .phoneNotNumber)
            return false
        }
        
        return true
    }
    
    private func showError(error: RegisterError) {
        self.error = error
        showError.toggle()
    }
}
