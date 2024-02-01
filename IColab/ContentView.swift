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
                if !showSignIn {
                    NavigationStack {
                        VStack{
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
                                    let pvm = ProfileViewModel()
                                    ProfileView(pvm: pvm, showSignIn: $showSignIn)
                                        .environmentObject(pvm)
                                case .payment:
                                    PaymentAdminView()
                                case .user:
                                    UserAdminView()
                                }
                            }
                        }
                        TabBarView(selectedTabItem: $selectedTabBar)
                    }
                    .navigationBarBackButtonHidden()
                    .navigationBarTitleDisplayMode(.large)
                }
                
            } else{
                LoadingView()
            }
        }
        .accentColor(.primary)
        .onAppear {
            self.isLoading = true
            
            if AuthenticationManager.shared.getLoggedInUser() != nil {
                AccountManager.shared.getAccount {
                    withAnimation {
                        self.isLoading = false
                    }
                }
                self.showSignIn = false
            } else {
                withAnimation {
                    self.isLoading = false
                    self.showSignIn = true
                }
            }
//            AccountManager.shared.getAccount(id: "ubDASCnrj2SyV419SwpJ39h7xby1") {
//                withAnimation {
//                    self.isLoading = false
//                }
//            }
//            self.showSignIn = false
            
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
