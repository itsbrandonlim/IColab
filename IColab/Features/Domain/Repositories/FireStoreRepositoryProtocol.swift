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
    func getDocumentFromID(collectionName: String, id: String, completion: @escaping (DocumentSnapshot)-> Void)
    
    func setDataWithID<T: Codable>(collectionName : String, element: T, id: String) -> Result<Bool, Error>
    func addProject(collectionName: String, element: Project) throws
    func addAccountDetail(accountDetail: AccountDetail, id: String, completion: @escaping (Error?) -> Void)
    
    func updateDocument<T: Codable>(collectionName: String, id: String, element: T) throws
    func updateProject(project: Project, completion: @escaping (Error?) -> Void)
    func addMembertoProject(project: Project, completion: @escaping (Error?) -> Void)
}
