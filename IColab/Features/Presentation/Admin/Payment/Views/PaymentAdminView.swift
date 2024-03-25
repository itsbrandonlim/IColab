//
//  PaymentAdminView.swift
//  IColab
//
//  Created by Jeremy Raymond on 13/01/24.
//

import SwiftUI

struct PaymentAdminView: View {
    @StateObject var vm: PaymentAdminViewModel = PaymentAdminViewModel()
    
    var body: some View {
        VStack {
            VStack {
                if vm.payments.isEmpty {
                    Text("Loading")
                }
                else {
                    ScrollView {
                        VStack {
                            ForEach(vm.payments) { payment in
                                PaymentAdminCardView(payment: payment)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .environmentObject(vm)
                        
                        Button {
                            vm.createPaymentButton()
                        } label: {
                            Text("Create Payment")
                        }
                        .buttonStyle(.borderedProminent)
                        Button {
                            vm.validate()
                        } label: {
                            Text("Validate Random Payment")
                        }
                        .buttonStyle(.bordered)
                    }
                    

                }
                
            }
            .navigationTitle("Payment")
            Spacer()
        }
        .onAppear {
            vm.getPayments() {
                if !vm.payments.isEmpty {
                    print("Payment loaded")
                    print(vm.payments.count)
                    vm.payments.shuffle()
                }
            }
        }
    }
}

#Preview {
    PaymentAdminView()
}
