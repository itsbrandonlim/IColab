//
//  AddDatatoFireStoreUsecase.swift
//  IColab
//
//  Created by Kevin Dallian on 12/12/23.
//

import Foundation

struct AddDatatoFireStoreUseCase {
    var repository = FireStoreRepository()
    
    func call(collectionName: String, element: Project) throws {
        try repository.addProject(collectionName: collectionName, element: element)
    }
}
