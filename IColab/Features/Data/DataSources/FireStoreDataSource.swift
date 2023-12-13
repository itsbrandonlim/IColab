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
    
    func getCollection(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void){
        db.collection(collectionName).getDocuments(completion: completion)
    }
    
    func setDataWithID<T>(collectionName: String, element: T, id: String) -> Result<Bool, Error> where T : Codable {
        let dataReference = db.collection(collectionName).document(id)
        do{
            try dataReference.setData(from: element)
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
    
    func getDocumentFromID(collectionName: String, id: String, completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
        let docReference = db.collection(collectionName).document(id)
        docReference.getDocument { documentSnapShot, error in
            if let error = error {
                completion(nil, error)
            }
            if let document = documentSnapShot, documentSnapShot!.exists {
                completion(document, nil)
            }
        }
    }
    
    func updateDocument<T:Codable>(collectionName: String, id: String, element: T) throws {
        let docReference = db.collection(collectionName).document(id)
        do{
            try docReference.setData(from: element)
        } catch let error{
            throw error
        }
    }
    
    func addProject(collectionName: String, element: Project) throws {
        let docReference = db.collection(collectionName).document()
        docReference.setData(element.toDict())
    }
}
