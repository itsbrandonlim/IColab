//
//  FireStoreRepositoryProtocol.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import FirebaseFirestore
import Foundation

protocol FireStoreRepositoryProtocol {
    func getCollection(collectionName : String, completion: @escaping (QuerySnapshot?, Error?)-> Void)
    func setData<T: Codable>(collectionName : String, element: T) -> Result<Bool, Error>
}
