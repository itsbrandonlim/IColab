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
    let projectConstants = FireStoreConstant.ProjectConstants()
    let detailConstants = FireStoreConstant.AccountDetailConstants()
    let paymentConstants = FireStoreConstant.PaymentConstants()
    func getCollection(collectionName: String, completion: @escaping (QuerySnapshot?, Error?) -> Void){
        db.collection(collectionName).getDocuments(completion: completion)
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
    
    func addProject(collectionName: String, project: Project) throws {
        let docReference = db.collection(collectionName).document(project.id)
        docReference.setData(project.toDict())
    }
    
    func addAccountDetail(accountDetail: AccountDetail, id: String, completion: @escaping (Error?) -> Void) {
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
        let docReference = db.collection(projectConstants.collectionName).document(project.id)
        
        docReference.setData(project.toDict()) { error in
            completion(error)
        }
    }
    
    func addMembertoProject(project: Project, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        let query = db.collection(projectConstants.collectionName).whereField(projectConstants.title, isEqualTo: project.title)
        query.getDocuments { querySnapShot, error in
            if let error = error {
                completion(nil, error)
            }
            else if let qss = querySnapShot {
                completion(qss, nil)
            }
        }
    }
    
    func fetchProjectsFromOwnerID(ownerID: String, completion: @escaping (Result<QuerySnapshot, Error>) -> Void){
        let query = db.collection(projectConstants.collectionName).whereField(projectConstants.ownerID, isEqualTo: ownerID)
        query.getDocuments { qss, error in
            if let error = error {
                completion(.failure(error))
            }else if let qss = qss {
                completion(.success(qss))
            }
        }
    }
    
    func setPayment(collectionName: String, payment: Payment) throws {
        let docReference = db.collection(collectionName).document(payment.id)
        docReference.setData(payment.toDict())
    }
    
    func deletePayment(collectionName: String, paymentId: String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
        let query = db.collection(collectionName).whereField(paymentConstants.id, isEqualTo: paymentId)
        query.getDocuments { querySnapShot, error in
            if let error = error {
                completion(nil, error)
            }
            else if let qss = querySnapShot {
                completion(qss, nil)
            }
        }
    }
    
    func fetchPaymentsFromGoalId(goalId: String, completion: @escaping (Result<QuerySnapshot, Error>) -> Void){
        let query = db.collection(paymentConstants.collectionName).whereField(paymentConstants.goalid, isEqualTo: goalId)
        query.getDocuments { qss, error in
            if let error = error {
                completion(.failure(error))
            }else if let qss = qss {
                completion(.success(qss))
            }
        }
    }
}
