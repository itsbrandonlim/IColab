//
//  FirestoreManager.swift
//  IColab
//
//  Created by Kevin Dallian on 08/12/23.
//

import Foundation
import FirebaseFirestore

class FireStoreManager {
    static let shared = FireStoreManager()
    
    private init() {}
    
    let db = Firestore.firestore()
    
    func getCollection(collectionName : String, completion : @escaping (_ : QuerySnapshot) -> Void){
        db.collection(collectionName).getDocuments() { (querySnapshot, err) in
            if err != nil {
                fatalError("error : \(String(describing: err?.localizedDescription))")
            }
            
            guard let qss = querySnapshot else {
                fatalError("No data found in querry SnapShot")
            }
            completion(qss)
        }
    }
    
    func setData<T: Codable>(collectionName : String, element: T) -> Result<Bool, Error>{
        do {
            let dataReference = db.collection(collectionName).document()
            try dataReference.setData(from: element)
            return .success(true)
        }catch let error {
            return .failure(error)
        }
    }
    
}
