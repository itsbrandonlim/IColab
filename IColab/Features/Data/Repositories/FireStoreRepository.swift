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
    
    func getCollection(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        firestoreDataSource.getCollection(collectionName: collectionName, completion: completion)
    }
    
    func setData<T>(collectionName: String, element: T) -> Result<Bool, Error> where T : Decodable, T : Encodable {
        switch firestoreDataSource.setData(collectionName: collectionName, element: element) {
            case .success(let boolean) :
                return .success(boolean)
            case .failure(let error) :
                return .failure(error)
        }
    }
}
