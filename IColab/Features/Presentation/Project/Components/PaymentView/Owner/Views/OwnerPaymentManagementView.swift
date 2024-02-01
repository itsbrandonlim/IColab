//
//  OwnerPaymentManagementView.swift
//  IColab
//
//  Created by Jeremy Raymond on 13/01/24.
//

import SwiftUI

enum AdminPaymentManagementPicker: String, CaseIterable {
    case current, history
}

struct OwnerPaymentManagementView: View {
    @State var picker: AdminPaymentManagementPicker = .current
    
    var body: some View {
        VStack {
            Picker("Payment Management Picker", selection: $picker) {
                ForEach(AdminPaymentManagementPicker.allCases, id: \.self) { picker in
                    Text(picker.rawValue.capitalized).tag(picker)
                }
            }
            .pickerStyle(.segmented)
            .padding(.vertical)
            
            VStack {
                ScrollView {
                    ForEach(0..<7) { _ in
                        PaymentStatusCardView(status: PaymentStatusEnum.allCases.randomElement()!)
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        
        .navigationTitle("Payment Management").navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        OwnerPaymentManagementView()
    }
}
