//
//  PaymentAdminCardView.swift
//  IColab
//
//  Created by Jeremy Raymond on 13/01/24.
//

import SwiftUI

struct PaymentAdminCardView: View {
    @EnvironmentObject var vm: PaymentAdminViewModel
    var payment: Payment
    
    var body: some View {
        NavigationLink {
            PaymentDetailAdminView(payment: payment)
                .environmentObject(vm)
        } label: {
            VStack(alignment: .leading) {
                Text(payment.id).bold()
                Text(String(payment.isValidated))
                Text(payment.owner)
                Text(payment.worker)
            }
            .multilineTextAlignment(.leading)
            .frame(width: 280, alignment: .leading)
            .padding()
            .padding(.trailing, 36)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        }

        
    }
}

#Preview {
    PaymentAdminCardView(payment: Payment(amount: 1000, owner: "Owner", worker: "Worker", project: "Project"))
}
