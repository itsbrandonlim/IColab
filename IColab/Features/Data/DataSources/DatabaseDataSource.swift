//
//  DatabaseDataSource.swift
//  IColab
//
//  Created by Kevin Dallian on 23/12/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct DatabaseDataSource : DatabaseDataSourceProtocol {
    private let db : DatabaseReference = Database.database(url: DatabaseConstant.databaseReferenceURL).reference()
    let chatConstants = DatabaseConstant.ChatConstants()
    let messageConstants = DatabaseConstant.MessageConstants()
    
    func initializeChat(chat: Chat, completion: @escaping (Result<String, Error>) -> Void) {
        db.child(chatConstants.parentName).child(chat.id).setValue(chat.toDict()) { error, databaseReference in
            if let error = error {
                completion(.failure(error))
            }else if let key = databaseReference.key{
                db.child(messageConstants.parentName).child(chat.id).setValue([:])
                completion(.success(key))
            }
        }
    }
    
    func fetchChats(accountID: String, completion: @escaping (Result<DataSnapshot, Error>) -> Void) {
        db.child(chatConstants.parentName).getData { error, snapshot in
            if let error = error {
                completion(.failure(error))
            }else if let snapshot = snapshot{
                completion(.success(snapshot))
            }
        }
    }
}
