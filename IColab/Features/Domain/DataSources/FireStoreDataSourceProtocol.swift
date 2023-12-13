//
//  FireStoreDataSourceProtocol.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import FirebaseFirestore
import Foundation

protocol FireStoreDataSourceProtocol {
    func getCollection(collectionName : String, completion: @escaping (QuerySnapshot?, Error?)-> Void)
    func getDocumentFromID(collectionName: String, id: String, completion: @escaping (DocumentSnapshot?, Error?)-> Void)
    
    func addAccountDetail(accountDetail: AccountDetail, id: String, completion: @escaping (Error?) -> Void)
    func addProject(collectionName: String, project: Project) throws
    func setDataWithID<T: Codable>(collectionName : String, element: T, id: String) -> Result<Bool, Error>
    
    func updateDocument<T: Codable>(collectionName: String, id: String, element: T) throws
    func updateProject(project: Project, completion: @escaping (Error?) -> Void)
    
    
}
