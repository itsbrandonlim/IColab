//
//  ProfileChatCard.swift
//  IColab
//
//  Created by Kevin Dallian on 30/12/23.
//

import SwiftUI

struct ProfileChatCard: View {
    var image : String?
    var name : String
    var caption : String?
    var body: some View {
        HStack {
            if let img = image {
                Image(img)
            } else {
                Circle()
                    .frame(width: 42)
                    .foregroundColor(Color(.purple))
            }
            VStack(alignment: .leading) {
                Text(name)
                    .bold()
                Text(caption ?? "")
                    .font(.caption)
            }
        }
    }
}

#Preview {
    ProfileChatCard(name: "Kevin", caption: "Project 1")
}
