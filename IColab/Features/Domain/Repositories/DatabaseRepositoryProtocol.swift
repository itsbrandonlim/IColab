//
//  DatabaseRepositoryProtocol.swift
//  IColab
//
//  Created by Kevin Dallian on 23/12/23.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

protocol DatabaseRepositoryProtocol {
    func initializeChat(chat: Chat, completion: @escaping (Result<String, Error>) -> Void)
    func fetchChats(accountID: String, completion: @escaping (Result<[Chat], Error>) -> Void)
}
