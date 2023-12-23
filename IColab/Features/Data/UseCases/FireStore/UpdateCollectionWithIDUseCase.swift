//
//  UpdateCollectionWithID.swift
//  IColab
//
//  Created by Kevin Dallian on 10/12/23.
//

import Foundation

struct UpdateCollectionWithIDUseCase {
    var repository = FireStoreRepository()
    
    func call<T: Codable>(collectionName: String, id: String, element: T) throws {
        try repository.updateDocument(collectionName: collectionName, id: id, element: element)
    }
}
