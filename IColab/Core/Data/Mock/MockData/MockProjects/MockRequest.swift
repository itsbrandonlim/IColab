//
//  MockRequest.swift
//  IColab
//
//  Created by Kevin Dallian on 19/10/23.
//

import Foundation

struct MockRequest {
    static var array : [Request] = [
        Request(worker:
                    Account(email: "kevin@gmail.com",
                            password: "kevin@123",
                            accountDetail:
                                AccountDetail(
                                    accountID: "", 
                                    name: "Kevin",
                                    desc: "Description",
                                    location: "Location",
                                    bankAccount: "Bank",
                                    cvLink: "cvLink")),
                role: .frontend,
                date: Date.now),
        Request(worker:
                    Account(email: "aaa@gmail.com",
                            password: "kevin@123",
                            accountDetail:
                                AccountDetail(
                                    accountID: "",
                                    name: "Raymond",
                                    desc: "",
                                    location: "",
                                    bankAccount: "",
                                    cvLink: "")),
                role: .backend,
                date: Date.now),
        Request(worker:
                    Account(email: "bbb@gmail.com",
                            password: "kevin@123",
                            accountDetail:
                                AccountDetail(
                                    accountID: "",
                                    name: "",
                                    desc: "",
                                    location: "",
                                    bankAccount: "",
                                    cvLink: "")
                           ),
                role: .design,
                date: Date.now),
    ]
}
