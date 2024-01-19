//
//  SetPaymentUseCase.swift
//  IColab
//
//  Created by Jeremy Raymond on 16/01/24.
//

import FirebaseFirestore
import Foundation

struct SetPaymentUseCase {
    var repository = FireStoreRepository()
    
    func call(payment: Payment) throws {
        try repository.setPayment(collectionName: FireStoreConstant.PaymentConstants().collectionName, payment: payment)
    }
}
