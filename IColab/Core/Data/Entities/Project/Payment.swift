//
//  Payment.swift
//  IColab
//
//  Created by Jeremy Raymond on 16/01/24.
//

import Foundation

class Payment: Identifiable {
    var id: String
    var amount: Double
    var owner: String
    var worker: String
    var project: String
    var isValidated: Bool
    
    init(id: String = UUID().uuidString, amount: Double, owner: String, worker: String, project: String, isValidated: Bool = false) {
        self.id = id
        self.amount = amount
        self.owner = owner
        self.worker = worker
        self.project = project
        self.isValidated = isValidated
    }
    
    public func toDict() -> [String: Any] {
        var dictionary = [String: Any]()
        let paymentConstants = FireStoreConstant.PaymentConstants()
        dictionary = [
            paymentConstants.id : self.id,
            paymentConstants.amount : self.amount,
            paymentConstants.ownerId : self.owner,
            paymentConstants.projectId : self.project,
            paymentConstants.workerId : self.worker,
            paymentConstants.isValidated : self.isValidated
            
        ]
        return dictionary
    }
    
    static func decode(from data: [String : Any]) -> Payment {
        let paymentConstants = FireStoreConstant.PaymentConstants()
        
        let id = data[paymentConstants.id] as! String
        let amount = data[paymentConstants.amount] as! Double
        let ownerId = data[paymentConstants.ownerId] as! String
        let projectId = data[paymentConstants.projectId] as! String
        let workerId = data[paymentConstants.workerId] as! String
        let isValidated = data[paymentConstants.isValidated] as! Bool
        
        return Payment(id: id, amount: amount, owner: ownerId, worker: workerId, project: projectId, isValidated: isValidated)
    }
    
    func validate() {
        self.isValidated = true
    }
}
