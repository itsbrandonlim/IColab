//
//  FireStoreRepository.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import FirebaseFirestore
import Foundation

struct FireStoreRepository : FireStoreRepositoryProtocol {
    let firestoreDataSource = FireStoreDataSource()
    
    func getCollection(collectionName: String, completion: @escaping (QuerySnapshot) -> Void) {
        firestoreDataSource.getCollection(collectionName: collectionName) { querySnapShot, error in
            if let error = error {
                fatalError("Error getting firebase collection : \(error.localizedDescription)")
            }
            if let qss = querySnapShot {
                completion(qss)
            }
        }
    }
    
    func setData<T>(collectionName: String, element: T, id: String) -> Result<Bool, Error> where T : Decodable, T : Encodable {
        switch firestoreDataSource.setData(collectionName: collectionName, element: element, id: id) {
            case .success(let boolean) :
                return .success(boolean)
            case .failure(let error) :
                return .failure(error)
        }
    }
    
    func getDocumentFormID(collectionName: String, id: String, completion: @escaping (DocumentSnapshot) -> Void) {
        firestoreDataSource.getDocumentFromID(collectionName: collectionName, id: id) { documentSnapShot, error in
            if let error = error {
                fatalError("Error getting firebase document from id: \(error)")
            }
            if let doc = documentSnapShot {
                completion(doc)
            }
        }
    }
}
