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
}

class UserDataManager {
    static let shared = UserDataManager()
    let userDatas : [UserData] = []
    
    private init() {}
    
    let db = Firestore.firestore()
    
    func addUser(username: String = "", email: String = "", phone: String = "", region: String = "") {
        db.collection("users").addDocument(data: [username: username, email: email, phone: phone, region: region])
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
