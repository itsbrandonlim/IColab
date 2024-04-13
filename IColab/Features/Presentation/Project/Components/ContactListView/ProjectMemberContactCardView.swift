//
//  ProjectMemberContactCardView.swift
//  IColab
//
//  Created by Jeremy Raymond on 07/10/23.
//

import SwiftUI

struct ProjectMemberContactCardView: View {
    var member : AccountDetail
    var role : String
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 48)
                .foregroundColor(.purple)
            Text(member.name)
                .bold()
                .multilineTextAlignment(.center)
            Text(role)
                .font(.caption)
        }
        .padding()
        .frame(maxWidth: 180, maxHeight: 180)
        .background(Color("gray"))
        .cornerRadius(12)
    }
}

#Preview {
    ProjectMemberContactCardView(member: AccountDetail(name: "Kevin", desc: "", location: "", bankAccount: "", phoneNumber: ""), role: "Back-End")
        .preferredColorScheme(.dark)
}
