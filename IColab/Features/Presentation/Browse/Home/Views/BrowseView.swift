//
//  HomeView.swift
//  IColab
//
//  Created by Kevin Dallian on 02/09/23.
//

import SwiftUI

struct BrowseView: View {
    @StateObject var homeViewModel = BrowseViewModel()
    @FocusState var isInputActive: Bool
    @State var isLoading = true
    var body: some View {
        VStack{
            HStack{
                SearchBar(searchText: $homeViewModel.searchText){ search in
                    homeViewModel.searchProject(searchTitle: search)
                }
                .focused($isInputActive)
                Button {
                    homeViewModel.searchPressed.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
            if !isLoading {
                if homeViewModel.projects.isEmpty{
                    VStack(spacing: 10){
                        Spacer()
                        Image(systemName: "menucard")
                            .font(.system(size: 64))
                        Text("No Projects to be shown")
                            .font(.title3.bold())
                        Spacer()
                        Spacer()
                    }
                }else{
                    ScrollView{
                        ForEach(homeViewModel.selectedProjects){ project in
                            NavigationLink {
                                ProjectDetailView(project: project)
                            } label: {
                                ProjectCard(project: project)
                            }
                        }
                    }
                }
            } else {
                Spacer()
                LoadingView()
                Spacer()
                Spacer()
            }
        }
        .onAppear(perform: {
            self.isLoading = true
            self.homeViewModel.getProjects {
                self.isLoading = false
            }
        })
        .padding(.horizontal, 20)
        .navigationTitle("Browse")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done"){
                    isInputActive = false
                }
            }
        }
        .sheet(isPresented: $homeViewModel.searchPressed) {
            FilterSheetView()
                .presentationDetents([.fraction(0.5), .large])
                .presentationDragIndicator(.visible)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            BrowseView()
        }
    }
}
