//
//  FireStoreRepository.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import FirebaseFirestore
import Foundation

struct FireStoreRepository : FireStoreRepositoryProtocol {
    let firestoreDataSource = FireStoreDataSource()
    
    func getCollection(collectionName: String, completion: @escaping (QuerySnapshot) -> Void) {
        firestoreDataSource.getCollection(collectionName: collectionName) { querySnapShot, error in
            if let error = error {
                fatalError("Error getting firebase collection : \(error.localizedDescription)")
            }
            if let qss = querySnapShot {
                completion(qss)
            }
        }
    }
    
    func getDocumentFromID(collectionName: String, id: String, completion: @escaping (DocumentSnapshot) -> Void) {
        firestoreDataSource.getDocumentFromID(collectionName: collectionName, id: id) { documentSnapShot, error in
            if let error = error {
                fatalError("Error getting firebase document from id: \(error)")
            }
            if let doc = documentSnapShot {
                completion(doc)
            }
        }
    }
    
    func addProject(collectionName: String, element: Project) throws {
        try firestoreDataSource.addProject(collectionName: collectionName, project: element)
    }
    
    func addAccountDetail(accountDetail: AccountDetail, id: String, completion: @escaping (Error?) -> Void) {
        firestoreDataSource.addAccountDetail(accountDetail: accountDetail, id: id, completion: completion)
    }
    
    func updateProject(project: Project, completion: @escaping (Error?) -> Void) {
        firestoreDataSource.updateProject(project: project, completion: completion)
    }
    
    func addMembertoProject(project: Project, completion: @escaping (Error?) -> Void) {
        firestoreDataSource.addMembertoProject(project: project) { querySnapShot, error in
            if let error = error {
                completion(error)
            } else{
                completion(nil)
            }
        }
    }
    
    func fetchProjectsFromOwnerID(ownerID: String, completion: @escaping (Result<[Project], Error>) -> Void) {
        firestoreDataSource.fetchProjectsFromOwnerID(ownerID: ownerID) { result in
            switch result {
            case .success(let querySnapShot):
                var projects : [Project] = []
                querySnapShot.documents.forEach { doc in
                    projects.append(Project.decode(from: doc.data()))
                }
                completion(.success(projects))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setPayment(collectionName: String, payment: Payment) throws {
        try firestoreDataSource.setPayment(collectionName: collectionName, payment: payment)
    }
}
