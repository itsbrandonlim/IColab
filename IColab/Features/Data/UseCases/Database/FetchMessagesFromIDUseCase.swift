//
//  FetchMessagesFromIDUseCase.swift
//  IColab
//
//  Created by Kevin Dallian on 27/12/23.
//

import Foundation

struct FetchMessagesFromIDUseCase {
    let repository = DatabaseRepository()
    
    public func call(chatID: String, completion: @escaping (Result<[Message], Error>) -> Void){
        repository.fetchMessagesFromChatID(chatID: chatID, completion: completion)
    }
}
