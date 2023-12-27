//
//  ChatBubbleView.swift
//  IColab
//
//  Created by Jeremy Raymond on 01/10/23.
//

import SwiftUI

struct ChatBubbleView: View {
    var message: Message = Message(text: "Example text", time: Date.now, senderID: UUID().uuidString)
    
    var body: some View {
        if message.senderID == AccountManager.shared.account!.id{
            HStack(alignment: .bottom) {
                Spacer()
                Text(message.time.formatted(date: .numeric, time: .shortened))
                    .font(.caption2)
                Text(message.text)
                    .frame(alignment: .topTrailing)
                    .padding(16)
                    .background(.purple)
                    .cornerRadius(12, corners: [.topLeft, .topRight, .bottomLeft])
                    .padding(.top, 12)
            }
        }
        else {
            HStack(alignment: .bottom) {
                VStack {
                    Circle()
                        .frame(width: 48)
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(maxHeight: 20)
                    Text(message.text)
                        .frame(alignment: .topLeading)
                        .padding(16)
                        .background(Color("gray"))
                        .cornerRadius(12, corners: [.bottomLeft, .bottomRight, .topRight])
                    Text(message.time.formatted(date: .numeric, time: .shortened))
                        .font(.caption2)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ChatBubbleView()
}
