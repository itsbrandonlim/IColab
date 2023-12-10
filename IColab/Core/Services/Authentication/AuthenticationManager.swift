//
//  AuthenticationManager.swift
//  IColab
//
//  Created by Kevin Dallian on 07/12/23.
//

import FirebaseAuth
import Foundation

class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init(){}
    
    func createUser(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func loginUser(email: String , password: String, completion: @escaping (AuthDataResult?, Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func getLoggedInUser() -> User?{
        return Auth.auth().currentUser
    }
    
    func logoutUser(){
        do {
            try Auth.auth().signOut()
            print("Logout")
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    var userSignedIn : Bool {
        return Auth.auth().currentUser != nil
    }
}
