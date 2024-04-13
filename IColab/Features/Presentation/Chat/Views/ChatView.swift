//
//  ChatView.swift
//  IColab
//
//  Created by Jeremy Raymond on 30/09/23.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var vm: ChatListViewModel
    @State var chat: Chat
    var turn: Bool = true
    @State var isLoading : Bool = true
    var fetchMessage = FetchMessagesFromIDUseCase()
    @Environment(\.presentationMode) var presentationMode
    
    @State var text: String = ""
    
    var body: some View {
        ZStack {
            if isLoading {
                Spacer()
                LoadingView()
                    .onAppear {
                        fetchMessage.call(chatID: chat.id) { result in
                            switch result {
                            case .success(let messages):
                                self.chat.messages.append(contentsOf: messages)
                                self.chat.messages.sort(by: {$0.time < $1.time})
                                self.isLoading = false
                            case .failure(let error):
                                print("Error fetching Messages from firebase : \(error.localizedDescription)")
                            }
                        }
                    }
                Spacer()
            }
            else{
                ScrollView {
                    VStack {
                        ForEach(chat.messages) { message in
                            ChatBubbleView(message: message)
                        }
                        Spacer()
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        TextField("Enter your message...", text: $text)
                            .padding()
                            .background(Color("gray"))
                            .cornerRadius(12)
                        Button(action: {
                            chat = vm.sendMessage(chat: chat, text: text, senderID: AccountManager.shared.account!.id)
                            self.text = ""
                            vm.objectWillChange.send()
                        }, label: {
                            Image(systemName: "paperplane.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.purple)
                        })                }
                    .padding(24)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        ProfileChatCard(name: chat.members.first(where: {$0.value != AccountManager.shared.account!.id})!.key, caption: chat.projectName)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ChatView(chat: Chat(title: "Chat", messages: [Message(text: "Hello", time: Date.now, senderID: UUID().uuidString)], type: .personal, projectName: "Project"))
}
