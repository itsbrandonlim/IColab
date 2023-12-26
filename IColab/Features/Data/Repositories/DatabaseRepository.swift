//
//  DatabaseRepository.swift
//  IColab
//
//  Created by Kevin Dallian on 23/12/23.
//

import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation

struct DatabaseRepository : DatabaseRepositoryProtocol {
    let databaseDataSource = DatabaseDataSource()
    
    func initializeChat(chat: Chat, completion: @escaping (Result<String, Error>) -> Void) {
        databaseDataSource.initializeChat(chat: chat, completion: completion)
    }
    
    func fetchChats(accountID: String, completion: @escaping (Result<[Chat], Error>) -> Void) {
        databaseDataSource.fetchChats(accountID: accountID) { result in
            switch result {
            case .success(let success):
                guard let value = success.value as? [String : Any] else {
                    return completion(.failure(URLError.badURL as! Error))
                }
                var chats : [Chat] = []
                value.forEach { (key: String, value: Any) in
                    var chat = Chat.decode(from: value as! [String : Any])
                    chat.id = key
                    chats.append(chat)
                }
                completion(.success(chats))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
