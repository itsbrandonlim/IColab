//
//  SetFireStoreDataUseCase.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import Foundation

struct SetFireStoreDataUseCase {
    var repository = FireStoreRepository()
    
    func call<T: Codable>(collectionName: String, element: T, id: String)-> Result<Bool, Error> {
        repository.setDataWithID(collectionName: collectionName, element: element, id: id)
    }
}
