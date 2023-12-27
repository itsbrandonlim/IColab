//
//  ProjectDetailView.swift
//  IColab
//
//  Created by Kevin Dallian on 02/09/23.
//

import SwiftUI


struct ProjectDetailView: View {
    var project : Project
    @State var pickerSelection : PickerItem = .overview
    @State var showSheet = false
    @State var showProfile = false
    @State var showChat = false
    @State var isLoading = true
    @State var chat : Chat?
    @State var owner : AccountDetail!
    var fetchOwner = FetchDocumentFromIDUseCase()
    let pickerItems : [PickerItem] = [.overview, .milestone]
    var body: some View {
        if !isLoading {
            ScrollView{
                ZStack(alignment: .bottomLeading){
                    Image("purple")
                        .resizable()
                        .frame(height: 200)
                    Text("\(project.title)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                }
                OwnerNameView(name: owner.name, showSheet: $showSheet)
                    .offset(y: -10)
                PickerView(pickerSelection: $pickerSelection, allItems: pickerItems)
                    .padding(.horizontal, 10)
                switch pickerSelection {
                case .overview:
                    OverviewView(project: project)
                case .milestone:
                    MilestoneView(milestones: project.milestones)
                default:
                    EmptyView()
                }
            }
            .ignoresSafeArea()
            .sheet(isPresented: $showSheet, content: {
                OwnerProfileSheet(owner: owner, showSheet: $showSheet, showProfile: $showProfile, showChat: $showChat, chat: $chat)
                    .presentationDragIndicator(.visible)
                .presentationDetents([.fraction(0.45), .large])
            })
            .navigationDestination(isPresented: $showProfile) {
                ProfileView(pvm: ProfileViewModel(accountDetail: owner), showSignIn: .constant(false))
                    .environmentObject(ProfileViewModel())
            }
            .navigationDestination(isPresented: $showChat) {
                ChatView(chat: chat ?? Chat(title: "", type: .personal, projectName: ""))
                    .environmentObject(ChatListViewModel())
            }
        } else {
            LoadingView()
                .onAppear{
                    self.fetchOwner.call(collectionName: "accountDetails", id: project.owner!, completion: { doc in
                        if let document = doc.data() {
                            let accountDetail = AccountDetail.decode(from: document)
                            self.owner = accountDetail
                            self.owner.id = doc.documentID
                            self.isLoading = false
                        }
                    })
                }
        }
        
    }
}
