//
//  DatabaseDataSourceProtocol.swift
//  IColab
//
//  Created by Kevin Dallian on 23/12/23.
//

import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation

protocol DatabaseDataSourceProtocol {
    func initializeChat(chat: Chat, completion: @escaping (Result<String, Error>) -> Void)
    func fetchChats(accountID: String, completion: @escaping (Result<DataSnapshot, Error>) -> Void)
    func addMessageToChat(chat: Chat, message: Message, completion: @escaping (Result<String, Error>) -> Void)
    func fetchMessagesFromChatID(chatID: String, completion: @escaping (Result<DataSnapshot, Error>) -> Void)
}
