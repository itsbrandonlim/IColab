//
//  OwnerProfileSheet.swift
//  IColab
//
//  Created by Kevin Dallian on 04/09/23.
//

import SwiftUI

struct OwnerProfileSheet: View {
    var owner : AccountDetail
    var projectTitle : String
    @Binding var showSheet : Bool
    @Binding var showProfile : Bool
    @Binding var showChat : Bool
    @Binding var chat : Chat?
    var addChat = AddChatUseCase()
    var body: some View {
        VStack(spacing: 10) {
            Circle()
                .foregroundColor(Color(.purple))
                .frame(width: 80)
            Text("\(owner.name)")
                .font(.headline)
            Text("\(owner.desc)")
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
            HStack{
                ButtonComponent(title: "View Profile", width: 140, tint: Color("graybutton")) {
                    showSheet = false
                    showProfile.toggle()
                }
                ButtonComponent(title: "Contact", width: 140) {
                    let fetchChatsUseCase = FetchChatUseCase()
                    var fetchedChat = [Chat]()
                    fetchChatsUseCase.call(accountID: owner.id ?? "") { result in
                        switch result {
                        case .success(let chats):
                            fetchedChat = chats.filter({$0.members.contains { (key: String, value: String) in
                                value == owner.id
                            }})
                            if let existingChat = fetchedChat.first(where: {$0.members.contains { (key: String, value: String) in
                                value == AccountManager.shared.account?.id
                            }}) {
                                self.chat = existingChat
                                showSheet = false
                                showChat = true
                            } else {
                                let newChat = Chat(title: "Personal Chat", messages: [], type: .personal, members: [owner.name:owner.id!, AccountManager.shared.account!.accountDetail.name: AccountManager.shared.account!.id],projectName: projectTitle)
                                addChat.call(chat: newChat ) { result in
                                    switch result {
                                    case .success(let success):
                                        print("Success adding chat with ID : \(success)")
                                        self.chat = newChat
                                        showSheet = false
                                        showChat = true
                                    case .failure(let failure):
                                        print("Error Adding chat : \(failure)")
                                    }
                                }
                            }
                            
                        case .failure(_):
                            fetchedChat = []
                        }
                    }
                    
                }
            }
            
        }
    }
}

struct OwnerProfileSheet_Previews: PreviewProvider {
    static var previews: some View {
        OwnerProfileSheet(owner: MockAccountDetails.array[0], projectTitle: "", showSheet: .constant(false), showProfile: .constant(false), showChat: .constant(false), chat: .constant(nil))
    }
}
