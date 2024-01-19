//
//  PaymentStatusCardView.swift
//  IColab
//
//  Created by Jeremy Raymond on 13/01/24.
//

import SwiftUI

enum PaymentStatusEnum: CaseIterable {
    case completed, incomplete
    
    func getIcon() -> String {
        switch self {
        case .completed:
            return "checkmark.circle"
        case .incomplete:
            return "wrongwaysign"
        }
    }
}

struct PaymentStatusCardView: View {
    var status: PaymentStatusEnum = .completed
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("John Doe")
                Text("3.000.000 $")
            }
            Spacer()
            
            Image(systemName: status.getIcon())
                .resizable()
                .frame(width: 32, height: 32)
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}

#Preview {
    PaymentStatusCardView()
}
