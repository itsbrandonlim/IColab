//
//  UserDataManager.swift
//  IColab
//
//  Created by Jeremy Raymond on 11/01/24.
//

import Foundation
import FirebaseFirestore

struct UserData {
    var username, email, phone, region : String
    var isAdmin: Bool = false
}

class UserDataManager {
    static let shared = UserDataManager()
    let userDatas : [UserData] = []
    
    private init() {}
    
    let db = Firestore.firestore()
    
    func addUser(userId: String, username: String = "", email: String = "", phone: String = "", region: String = "", isAdmin: Bool = false) {
        db.collection("users").document(userId).setData([
            "username" : username,
            "email" : email,
            "phone" : phone,
            "region" : region,
            "isAdmin" : isAdmin
        ])
    }
    
    func getCollection() -> [UserData] {
        if userDatas.isEmpty {
            db.collection("users").getDocuments() { (querySnapshot, err) in
                if err != nil {
                    fatalError("error : \(String(describing: err?.localizedDescription))")
                }
                
                guard let qss = querySnapshot else {
                    fatalError("No data found in querry SnapShot")
                }
            }
        }
        
        return userDatas
    }
}
