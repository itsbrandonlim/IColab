//
//  ContactView.swift
//  IColab
//
//  Created by Jeremy Raymond on 29/09/23.
//

import SwiftUI

struct ContactView: View {
    var chat: Chat = MockChats.array[0]
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(.purple)
                if chat.type == .owner {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "crown.fill")
                                .font(.caption2)
                        }
                        Spacer()
                    }
                }
            }
            .frame(width: 48, height: 48)
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(chat.type == .personal ? chat.members.filter({$0.value != AccountManager.shared.account?.id}).first?.key ?? "Personal Chat" : chat.title)
                                .lineLimit(1)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                            Text(chat.projectName)
                                .truncationMode(.tail)
                                .lineLimit(2)
                                .font(.caption2)
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                        Text(chat.lastMessage ?? "No Message found in this chat")
                            .multilineTextAlignment(.leading)
                            .font(.footnote)
                    }
                    .frame(width: 250, alignment: .leading)
                    VStack(alignment: .trailing) {
                        Text(chat.messages.first?.time ?? Date.now, style: .time)
                            .font(.footnote)
                        if chat.isPinned {
                            Image(systemName: "pin.circle")
                                .font(.caption2)
                        }
                        Divider()
                    }
                }
                Divider()
                    .background(.white)
            }
            .padding(8)
        }
    }
}

#Preview {
    ContactView()
}
