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
    @State var tabBarItems: [TabBarType] = [.home, .projects, .chats, .notifications, .profile]
    var fetchTabBars = FetchDocumentFromIDUseCase()
    
    var body: some View {
        ZStack{
            if !isLoading {
                if !showSignIn {
                    NavigationStack {
                        VStack{
                            VStack{
                                switch selectedTabBar {
                                case .home:
                                    BrowseView()
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
                        TabBarView(selectedTabItem: $selectedTabBar, tabBarItems: tabBarItems)
                    }
                    .navigationBarBackButtonHidden()
                    .navigationBarTitleDisplayMode(.large)
                }
                
            } 
            else{
                LoadingView()
                    .onAppear {
                        self.fetchTabBars.call(collectionName: "users", id: AuthenticationManager.shared.getLoggedInUser()?.uid ?? "-") { doc in
                            if doc.exists {
                                if let data = doc.data() {
                                    if data["isAdmin"] as? Bool == true {
                                        self.tabBarItems = TabBarType.getAdminTabs()
                                    }
                                    else {
                                        self.tabBarItems = TabBarType.getUserTabs()
                                    }
                                }
                                isLoading = false
                            }
                            else {
                                isLoading = true
                            }
                        }
                        if self.tabBarItems.isEmpty {
                            isLoading = true
                        }
                    }
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
