//
//  PortofolioView.swift
//  IColab
//
//  Created by Kevin Dallian on 02/10/23.
//

import SwiftUI

struct PortofolioView: View {
    @EnvironmentObject var pvm : ProfileViewModel
    var body: some View {
        if let account = pvm.account {
            GridView(rows: (account.accountDetail.projectsOwned.count) / 2 + 1, columns: 2) { row, column in
                let objectIndex = row * 2 + column
                if objectIndex < pvm.account?.accountDetail.projectsOwned.count ?? 0 {
                    NavigationLink{
                        ProjectDetailView(project: pvm.account!.accountDetail.projectsOwned[objectIndex])
                    } label: {
                        PortofolioCard(project: pvm.account!.accountDetail.projectsOwned[objectIndex])
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    PortofolioView()
        .environmentObject(ProfileViewModel())
}
