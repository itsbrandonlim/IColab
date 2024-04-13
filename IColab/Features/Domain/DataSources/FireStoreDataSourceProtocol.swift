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
    
    func updateProject(project: Project, completion: @escaping (Error?) -> Void)
    func addMembertoProject(project: Project, completion: @escaping (QuerySnapshot?, Error?) -> Void)
    func fetchProjectsFromOwnerID(ownerID: String, completion: @escaping (Result<QuerySnapshot, Error>) -> Void)
}
