//
//  UserAdminCardView.swift
//  IColab
//
//  Created by Jeremy Raymond on 13/01/24.
//

import SwiftUI

struct UserAdminCardView: View {
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.purple)
                .frame(width: 48, height: 48)
            VStack(alignment: .leading) {
                Text("User Name")
                Text("ID: 12345678")
                Text("Role: Backend Developer")
            }
            Spacer()
        }
        .padding()
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

#Preview {
    UserAdminCardView()
}
