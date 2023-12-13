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
    @Published var isLoading = false
    @Binding var showSignIn : Bool
    
    var accountDetailConstant = FireStoreConstant.AccountDetailConstants()
    var addAccountDetailtoFireStore = AddAccountDetailUseCase()
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
        self.isLoading = true
        if registrationValidation() {
            AuthenticationManager.shared.createUser(email: self.email, password: self.password) { authDataResult, error in
                if let error = error {
                    self.showError(error: .firebaseError(error))
                    self.isLoading = false
                }else{
                    if let result = authDataResult {
                        let accountDetail = AccountDetail(name: self.username, desc: "", location: self.region, bankAccount: "", phoneNumber: "")
                        let account = Account(email: result.user.email!, password: self.password, accountDetail: accountDetail)
//                        switch self.setData.call(collectionName: self.accountDetailConstant.collectionName, element: accountDetail, id: result.user.uid) {
//                        case .success(_):
//                            AccountManager.shared.getAccount()
//                            self.isLoading = false
//                            self.showSignIn = false
//                        case .failure(let failure):
//                            self.showError(error: .firebaseError(failure))
//                        }
                        self.addAccountDetailtoFireStore.call(accountDetail: accountDetail, id: result.user.uid) { error in
                            if let error = error {
                                self.showError(error: .firebaseError(error))
                            }
                            AccountManager.shared.getAccount()
                            self.isLoading = false
                            self.showSignIn = false
                        }
                        
                    }
                    
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
