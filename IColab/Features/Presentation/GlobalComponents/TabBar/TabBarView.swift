//
//  TabBarView.swift
//  IColab
//
//  Created by Kevin Dallian on 02/09/23.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTabItem : TabBarType
    @State var tabBarItems: [TabBarType]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                ForEach(tabBarItems, id: \.self){ tabBarType in
                    TabBarItemComponent(tabBarType: tabBarType) {
                        selectedTabItem = tabBarType
                    }
                    .frame(width: geometry.size.width * 0.2)
                    .foregroundColor(tabBarType == selectedTabItem ? .blue : .primary)
                    .onAppear {
//                        self.getTabBars() 
                    }
                }.offset(y: 5)
                Spacer()
            }
        }
        .frame(height: 50)
    }
    
    func getTabBars() {
        tabBarItems = TabBarType.getTabs(userId: AuthenticationManager.shared.getLoggedInUser()?.uid ?? "-")
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            BrowseView()
            TabBarView(selectedTabItem: .constant(.home), tabBarItems: [.home])
        }
        
    }
}
