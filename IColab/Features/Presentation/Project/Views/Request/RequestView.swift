//
//  RequestView.swift
//  IColab
//
//  Created by Kevin Dallian on 19/10/23.
//

import SwiftUI

struct RequestView: View {
    @EnvironmentObject var vm : ProjectOverviewViewModel
    @State var chosenIndex : Int = 0
    @State var showSheet = false
    @State var showProfile = false
    @State var owner : AccountDetail!
    var body: some View {
        VStack{
            if vm.project.requests.isEmpty {
                Image(systemName: "filemenu.and.cursorarrow")
                    .font(.system(size: 64))
                Text("No Requests")
                    .font(.title3).bold()
            }else{
                ForEach(vm.project.requests, id: \.id) { request in
                    Button {
                        self.chosenIndex = vm.project.requests.firstIndex(of: request) ?? 0
                        vm.fetchOwner(ownerID: vm.project.requests[chosenIndex].workerID)
                        showSheet = true
                    } label: {
                        RequestCard(request: request)
                            .environmentObject(vm)
                    }

                }
                .navigationDestination(isPresented: $showProfile) {
                    ProfileView(pvm: ProfileViewModel(accountDetail: vm.requestAccount), showSignIn: .constant(false))
                        .environmentObject(ProfileViewModel())
                }
            }
        }
        .sheet(isPresented: $showSheet, content: {
            VStack{
                RequestSheet(request: vm.project.requests[chosenIndex], showSheet: $showSheet, showProfile: $showProfile)
            }
            .presentationDragIndicator(.visible)
            .presentationDetents([.fraction(0.45), .large])
        })
        .navigationTitle("Request List")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        RequestView()
            .navigationBarTitleDisplayMode(.inline)
            .environmentObject(ProjectOverviewViewModel(project: Mock.projects[0]))
    }
}
