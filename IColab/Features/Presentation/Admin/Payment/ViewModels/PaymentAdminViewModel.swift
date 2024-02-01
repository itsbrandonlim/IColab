//
//  PaymentAdminViewModel.swift
//  IColab
//
//  Created by Jeremy Raymond on 16/01/24.
//

import Foundation

class PaymentAdminViewModel: ObservableObject {
    @Published var payments: [Payment] = []
    var fetchPayments = FetchCollectionUseCase()
    var setPayment = SetPaymentUseCase()
    
    public func getPayments(completion: @escaping ()->Void){
        let paymentConstants = FireStoreConstant.PaymentConstants()
        var allPayments : [Payment] = []
        fetchPayments.call(collectionName: paymentConstants.collectionName) { querySnapShot in
            querySnapShot.documents.forEach { doc in
                let payment = Payment.decode(from: doc.data())
                allPayments.append(payment)
            }
            
            self.payments = allPayments
            self.objectWillChange.send()
            completion()
        }
    }
    
    public func createPaymentButton() {
        do {
           try self.setPayment.call(payment: Payment(amount: 1234, owner: "Test Owner", worker: "Test Worker", project: "Test Project", goal: "Test goal"))
            self.objectWillChange.send()
        }
        catch {
            print("Failed creating Payment")
        }
    }
    
    public func validate() {
        var validatedPayment = self.payments.randomElement()!
        validatedPayment.validate()
        
        do {
            try self.setPayment.call(payment: validatedPayment)
        }
        catch {
            print("Failed creating Payment")
        }
    }
}
