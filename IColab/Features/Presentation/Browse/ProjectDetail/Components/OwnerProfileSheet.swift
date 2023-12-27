//
//  OwnerProfileSheet.swift
//  IColab
//
//  Created by Kevin Dallian on 04/09/23.
//

import SwiftUI

struct OwnerProfileSheet: View {
    var owner : AccountDetail
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
                    let chat = Chat(title: "Personal Chat", messages: [], type: .personal, members: [owner.name:owner.id!, AccountManager.shared.account!.accountDetail.name: AccountManager.shared.account!.id],projectName: "Project")
                    addChat.call(chat: chat) { result in
                        switch result {
                        case .success(let success):
                            print("Success adding chat with ID : \(success)")
                            self.chat = chat
                            showSheet = false
                            showChat = true
                        case .failure(let failure):
                            print("Error Adding chat : \(failure)")
                        }
                    }
                }
            }
            
        }
    }
}

struct OwnerProfileSheet_Previews: PreviewProvider {
    static var previews: some View {
        OwnerProfileSheet(owner: MockAccountDetails.array[0], showSheet: .constant(false), showProfile: .constant(false), showChat: .constant(false), chat: .constant(nil))
    }
}
