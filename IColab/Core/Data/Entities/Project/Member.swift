//
//  Member.swift
//  IColab
//
//  Created by Jeremy Raymond on 01/10/23.
//

import Foundation

struct Member: Identifiable, Equatable{
    let id: UUID = UUID()
    
    var accountDetail: AccountDetail
    var role: Role
    
    mutating func setAccount(accountDetail: AccountDetail) {
        self.accountDetail = accountDetail
    }
    
    static func decode(from data: [String:Any]) -> Member {
        let accountDetail = AccountDetail.decode(from: (data["accountDetail"] as? [String:Any] ?? [:]))
        let role = Role(rawValue: (data["role"] as! String))
        return Member(accountDetail: accountDetail, role: role!)
    }
}
