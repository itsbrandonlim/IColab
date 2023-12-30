//
//  FetchProjectsFromOwnerID.swift
//  IColab
//
//  Created by Kevin Dallian on 30/12/23.
//

import SwiftUI

struct FetchProjectsFromOwnerID {
    let repository = FireStoreRepository()
    
    public func call(ownerID: String, completion: @escaping (Result<[Project], Error>) -> Void) {
        repository.fetchProjectsFromOwnerID(ownerID: ownerID, completion: completion)
    }
}
