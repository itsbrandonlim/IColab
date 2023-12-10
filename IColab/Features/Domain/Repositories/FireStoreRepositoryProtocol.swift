//
//  FireStoreRepositoryProtocol.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import FirebaseFirestore
import Foundation

protocol FireStoreRepositoryProtocol {
    func getCollection(collectionName : String, completion: @escaping (QuerySnapshot)-> Void)
    func setData<T: Codable>(collectionName : String, element: T, id: String) -> Result<Bool, Error>
    func getDocumentFromID(collectionName: String, id: String, completion: @escaping (DocumentSnapshot)-> Void)
    func updateDocument<T: Codable>(collectionName: String, id: String, element: T) throws
}
