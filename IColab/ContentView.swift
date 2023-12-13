//
//  ContentView.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 7/30/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTabBar : TabBarType = .home
    @ObservedObject var accountManager = AccountManager.shared
    @State var showSignIn : Bool = false
    @State var isLoading : Bool = false
    var body: some View {
        ZStack{
            if !isLoading {
                NavigationStack {
                    ScrollView{
                        VStack{
                            switch selectedTabBar {
                            case .home:
                                HomeView()
                            case .projects:
                                ProjectMainView()
                            case .chats:
                                ChatListView()
                            case .notifications:
                                NotificationView()
                            case .profile:
                                let pvm = ProfileViewModel(uid: accountManager.account?.id ?? "")
                                ProfileView(pvm: pvm, showSignIn: $showSignIn)
                                    .environmentObject(pvm)
                            }
                        }
                    }
                    TabBarView(selectedTabItem: $selectedTabBar)
                }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.large)
            } else{
                LoadingView()
            }
        }
        .accentColor(.primary)
        .onAppear {
            self.isLoading = true
            if AuthenticationManager.shared.getLoggedInUser() != nil {
                AccountManager.shared.getAccount()
                self.showSignIn = false
            } else {
                self.showSignIn = true
            }
            self.isLoading = false
        }
        .fullScreenCover(isPresented: $showSignIn) {
            NavigationStack{
                LoginView(lvm: LoginViewModel(showSignIn: $showSignIn))
            }
        }
        .onChange(of: showSignIn) { _ in
            if showSignIn {
                selectedTabBar = .home
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
