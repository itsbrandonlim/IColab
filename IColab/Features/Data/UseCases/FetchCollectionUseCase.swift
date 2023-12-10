//
//  FetchCollectionUseCase.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import FirebaseFirestore
import Foundation

struct FetchCollectionUseCase {
    var repository = FireStoreRepository()
    
    func call(collectionName : String, completion: @escaping (QuerySnapshot?, Error?) -> Void){
        repository.getCollection(collectionName: collectionName, completion: completion)
    }
}
