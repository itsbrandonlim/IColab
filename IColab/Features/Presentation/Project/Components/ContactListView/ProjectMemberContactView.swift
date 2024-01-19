//
//  ProjectMemberContactView.swift
//  IColab
//
//  Created by Jeremy Raymond on 07/10/23.
//

import SwiftUI

struct ProjectMemberContactView: View {
    var title: String
    var project: Project
    @State var toggle: Bool
    @State var isLoading : Bool
    @State var members : [AccountDetail]
    @State var searchedMembers : [AccountDetail]
    @State var selectedMember : AccountDetail!
    @State var chat : Chat?
    @State var searchText : String = ""
    @FocusState var isInputActive: Bool
    
    @State var showSheet : Bool
    @State var showProfile : Bool
    @State var showChat : Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    init(title: String = "Title", project: Project = MockProjects.array[0], toggle: Bool = true, isLoading: Bool = false, members: [AccountDetail] = [], selectedMember: AccountDetail? = nil, chat: Chat? = nil, showSheet: Bool = false, showProfile: Bool = false, showChat: Bool = false) {
        self.title = title
        self.project = project
        self.toggle = toggle
        self.isLoading = isLoading
        self.members = members
        self.selectedMember = selectedMember
        self.searchedMembers = members
        self.chat = chat
        self.showSheet = showSheet
        self.showProfile = showProfile
        self.showChat = showChat
    }
    
    func fetchMembers() {
        self.isLoading = true
        let fetchAccountDetail = FetchDocumentFromIDUseCase()
        let accountDetailConstants = FireStoreConstant.AccountDetailConstants()
        var callRemaining = project.members.count
        for member in project.members {
            fetchAccountDetail.call(collectionName: accountDetailConstants.collectionName, id: member.workerID) { doc in
                if let data = doc.data() {
                    let member = AccountDetail.decode(from: data)
                    if !members.contains(where: {$0.id == doc.documentID}) {
                        member.id = doc.documentID
                        members.append(member)
                    }
                }
                callRemaining -= 1
                if callRemaining == 0 {
                    self.isLoading = false
                }
            }
        }
    }
    
    func searchMember(searchTitle: String) {
        if searchTitle == "" {
            self.searchedMembers = self.members
        } else {
            let allMembers = self.members
            let filteredMembers = allMembers.filter { accountDetail in
                let lowercasedName = accountDetail.name.lowercased()
                return lowercasedName.contains(searchTitle.lowercased())
            }
            self.searchedMembers = filteredMembers
        }
    }
    
    var body: some View {
        VStack {
            Button {
                toggle.toggle()
            } label: {
                HStack {
                    Text(title)
                        .font(.headline)
                    Spacer()
                    Image(systemName: toggle ? "chevron.down" : "chevron.up")
                    
                }
            }
            .padding(.horizontal)
            .buttonStyle(.plain)
            Divider()
                .background(.white)
            
            if toggle {
                if isLoading {
                    LoadingView()
                } else{
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<members.count) { i in
                            Button {
                                self.selectedMember = members[i]
                            } label: {
                                ProjectMemberContactCardView(member: members[i], role: project.members[i].role.rawValue)
                            }
                        }
                    }
                }
            } 
        }
        .onAppear{
            self.fetchMembers()
        }
        .sheet(item: $selectedMember, content: { member in
            OwnerProfileSheet(owner: member, projectTitle: project.title, showSheet: $showSheet, showProfile: $showProfile, showChat: $showChat, chat: $chat)
            .presentationDragIndicator(.visible)
            .presentationDetents([.fraction(0.45), .large])
        })
        .navigationDestination(isPresented: $showProfile) {
            ProfileView(pvm: ProfileViewModel(accountDetail: selectedMember ?? AccountDetail(name: "", desc: "", location: "", bankAccount: "", phoneNumber: "")), showSignIn: .constant(false))
                .environmentObject(ProfileViewModel())
        }
        .navigationDestination(isPresented: $showChat) {
            ChatView(chat: chat ?? Chat(title: "", type: .personal, projectName: ""))
                .environmentObject(ChatListViewModel())
        }
        .animation(.easeInOut, value: toggle)
    }
}

#Preview {
    ProjectMemberContactView()
}
