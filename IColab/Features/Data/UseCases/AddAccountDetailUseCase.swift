//
//  AddAccountDetailUseCase.swift
//  IColab
//
//  Created by Kevin Dallian on 13/12/23.
//

import Foundation

struct AddAccountDetailUseCase {
    var repository = FireStoreRepository()
    
    func call(accountDetail: AccountDetail, id: String, completion: @escaping (Error?) -> Void){
        repository.addAccountDetail(accountDetail: accountDetail, id: id, completion: completion)
    }
}
