//
//  DatabaseRepository.swift
//  IColab
//
//  Created by Kevin Dallian on 23/12/23.
//

import Foundation

struct DatabaseRepository : DatabaseRepositoryProtocol {
    let databaseDataSource = DatabaseDataSource()
    
    func initializeChat(chat: Chat, completion: @escaping (Result<String, Error>) -> Void) {
        databaseDataSource.initializeChat(chat: chat, completion: completion)
    }
}
