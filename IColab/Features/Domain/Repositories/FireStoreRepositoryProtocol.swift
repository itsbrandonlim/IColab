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
    
    func addProject(collectionName: String, element: Project) throws
    func addAccountDetail(accountDetail: AccountDetail, id: String, completion: @escaping (Error?) -> Void)
    
    func updateProject(project: Project, completion: @escaping (Error?) -> Void)
    func addMembertoProject(project: Project, completion: @escaping (Error?) -> Void)
    func fetchProjectsFromOwnerID(ownerID: String, completion: @escaping (Result<[Project], Error>) -> Void)
}
