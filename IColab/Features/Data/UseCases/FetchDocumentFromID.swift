//
//  FetchDocumentFromID.swift
//  IColab
//
//  Created by Kevin Dallian on 10/12/23.
//

import FirebaseFirestore
import Foundation

struct FetchDocumentFromID {
    var repository = FireStoreRepository()
    
    public func call(collectionName: String, id: String, completion: @escaping (DocumentSnapshot)-> Void) {
        repository.getDocumentFormID(collectionName: collectionName, id: id, completion: completion)
    }
}
