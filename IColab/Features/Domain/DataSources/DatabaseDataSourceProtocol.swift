//
//  DatabaseDataSourceProtocol.swift
//  IColab
//
//  Created by Kevin Dallian on 23/12/23.
//

import Foundation

protocol DatabaseDataSourceProtocol {
    func initializeChat(chat: Chat, completion: @escaping (Result<String, Error>) -> Void)
}
