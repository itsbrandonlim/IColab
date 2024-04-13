//
//  AddChatUseCase.swift
//  IColab
//
//  Created by Kevin Dallian on 23/12/23.
//

import Foundation

struct AddChatUseCase {
    let repository = DatabaseRepository()
    
    func call(chat: Chat, completion: @escaping (Result<String, Error>) -> Void) {
        repository.initializeChat(chat: chat, completion: completion)
    }
}
