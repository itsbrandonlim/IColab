//
//  FireStoreDataSource.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import FirebaseFirestore
import Foundation

struct FireStoreDataSource : FireStoreDataSourceProtocol {
    private let db = Firestore.firestore()
    
    func getCollection(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        db.collection(collectionName).getDocuments(completion: completion)
    }
    
    func setData<T>(collectionName: String, element: T) -> Result<Bool, Error> where T : Codable {
        let dataReference = db.collection(collectionName).document()
        do{
            try dataReference.setData(from: element)
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
    
    
}
