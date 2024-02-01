//
//  PaymentDetailAdminView.swift
//  IColab
//
//  Created by Jeremy Raymond on 16/01/24.
//

import SwiftUI

struct PaymentDetailAdminView: View {
    @EnvironmentObject var vm: PaymentAdminViewModel
    var payment: Payment
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(payment.id).bold()
                Text(String(payment.isValidated))
                Text(payment.owner)
                Text(payment.worker)
                Text(payment.project)
                Text("\(payment.amount)")
            }
            .frame(width: 280, alignment: .leading)
            .padding()
            .padding(.trailing, 36)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            
            HStack() {
                Image(systemName: "paperclip")
                Text("Photo File.jpg")
            }
            .bold()
            .frame(width: 300, alignment: .leading)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .padding()
            
            ButtonComponent(title: "Confirm", width: 320) {
                vm.validate()
            }
            ButtonComponent(title: "Reject", width: 320, tint: .red) {
                //
            }
            Spacer()
        }
        .navigationTitle("Details")
    }
}

#Preview {
    PaymentDetailAdminView(payment: Payment(amount: 1000, owner: "Owner", worker: "Worker", project: "Project", goal: "Some goal idk"))
}
