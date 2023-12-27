//
//  AddMessagetoChatUseCase.swift
//  IColab
//
//  Created by Kevin Dallian on 26/12/23.
//

import Foundation

struct AddMessagetoChatUseCase {
    let repository = DatabaseRepository()
    
    func call(chat: Chat, message: Message, completion: @escaping (Result<String, Error>) -> Void) {
        repository.addMessageToChat(chat: chat, message: message, completion: completion)
    }
}
