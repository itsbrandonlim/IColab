//
//  UserAdminView.swift
//  ICoaab
//
//  Created by Jeremy Raymond on 11/01/24.
//

import SwiftUI

struct UserAdminView: View {
    var body: some View {
        VStack{
            ScrollView{
                ForEach(1..<7) { notification in
                    UserAdminCardView()
                }
            }
        }.navigationTitle("Users")
        Spacer()
    }
}

#Preview {
    NavigationStack {
        UserAdminView()
    }
}
