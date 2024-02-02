//
//  ContactListView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct ContactListView: View {
    @EnvironmentObject var vm: ProjectOverviewViewModel
    var project: Project
    @State var owner : AccountDetail?
    @State var toggle : Bool = true
    @State var isLoading : Bool = false
    
    @StateObject var homeViewModel = BrowseViewModel()
        
    var body: some View {
        VStack {
            if AccountManager.shared.account?.id != project.owner {
                Button {
                    toggle.toggle()
                } label: {
                    HStack {
                        Text("Owner")
                            .font(.headline)
                        Spacer()
                        Image(systemName: toggle ? "chevron.down" : "chevron.up")
                    }
                }
                .onAppear{
                    self.fetchOwner()
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
                Divider()
                    .background(.white)
                if toggle {
                    if isLoading {
                        LoadingView()
                    } else{
                        ProjectMemberContactCardView(member: owner ?? AccountDetail(name: "", desc: "", location: "", bankAccount: "", phoneNumber: ""), role: "Owner")
                            
                    }
                }
            }
            ScrollView {
                ProjectMemberContactView(title: "Members", project: project)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        
    }
    
    func fetchOwner(){
        self.isLoading = true
        let fetchOwner = FetchDocumentFromIDUseCase()
        fetchOwner.call(collectionName: "accountDetails", id: project.owner ?? "") { doc in
            if let document = doc.data() {
                let accountDetail = AccountDetail.decode(from: document)
                accountDetail.id = doc.documentID
                self.owner = accountDetail
                self.isLoading = false
            }
        }
    }
}

//struct ContactListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactListView()
//            .preferredColorScheme(.dark)
//    }
//}
