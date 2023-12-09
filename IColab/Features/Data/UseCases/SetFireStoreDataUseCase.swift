//
//  SetFireStoreDataUseCase.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import Foundation

struct SetFireStoreDataUseCase {
    var repository = FireStoreRepository()
    
    func call<T: Codable>(collectionName: String, element: T)-> Result<Bool, Error> {
        repository.setData(collectionName: collectionName, element: element)
    }
}
