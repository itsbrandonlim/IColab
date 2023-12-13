//
//  FireStoreDataSource.swift
//  IColab
//
//  Created by Kevin Dallian on 09/12/23.
//

import FirebaseFirestore
import Foundation

struct FireStoreDataSource : FireStoreDataSourceProtocol {
    private let db = Firestore.firestore()
    
    func getCollection(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void){
        db.collection(collectionName).getDocuments(completion: completion)
    }
    
    func setDataWithID<T>(collectionName: String, element: T, id: String) -> Result<Bool, Error> where T : Codable {
        let dataReference = db.collection(collectionName).document(id)
        do{
            try dataReference.setData(from: element)
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
    
    func getDocumentFromID(collectionName: String, id: String, completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
        let docReference = db.collection(collectionName).document(id)
        docReference.getDocument { documentSnapShot, error in
            if let error = error {
                completion(nil, error)
            }
            if let document = documentSnapShot, documentSnapShot!.exists {
                completion(document, nil)
            }
        }
    }
    
    func updateDocument<T:Codable>(collectionName: String, id: String, element: T) throws {
        let docReference = db.collection(collectionName).document(id)
        do{
            try docReference.setData(from: element)
        } catch let error{
            throw error
        }
    }
    
    func addProject(collectionName: String, project: Project) throws {
        let docReference = db.collection(collectionName).document(project.id)
        docReference.setData(project.toDict())
    }
    
    func addAccountDetail(accountDetail: AccountDetail, id: String, completion: @escaping (Error?) -> Void) {
        var detailConstants = FireStoreConstant.AccountDetailConstants()
        let docReference = db.collection(detailConstants.collectionName).document(id)
        docReference.setData(accountDetail.toDict()) { error in
            if let error = error {
                completion(error)
            } else{
                completion(nil)
            }
        }
    }
    
    func updateProject(project: Project, completion: @escaping (Error?) -> Void) {
        var projectConstants = FireStoreConstant.ProjectConstants()
        let docReference = db.collection(projectConstants.collectionName).document(project.id)
        
        docReference.setData(project.toDict()) { error in
            completion(error)
        }
    }
}
