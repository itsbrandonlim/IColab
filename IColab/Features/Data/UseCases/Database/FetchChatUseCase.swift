//
//  FetchChat.swift
//  IColab
//
//  Created by Kevin Dallian on 26/12/23.
//

import Foundation

struct FetchChatUseCase {
    let repository = DatabaseRepository()
    
    func call(accountID: String, completion: @escaping (Result<[Chat], Error>) -> Void) {
        repository.fetchChats(accountID: accountID, completion: completion)
    }
}
