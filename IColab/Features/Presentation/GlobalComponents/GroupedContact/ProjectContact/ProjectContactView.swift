//
//  ProjectContactView.swift
//  IColab
//
//  Created by Jeremy Raymond on 04/10/23.
//

import SwiftUI

struct ProjectContactView: View {
    @StateObject var vm : ProjectContactViewModel
    @State var toggle: Bool = true
    
    var body: some View {
        VStack {
            if vm.isLoading {
                Spacer()
                LoadingView()
                Spacer()
            } else {
                Button {
                    toggle.toggle()
                } label: {
                    HStack {
                        Text(vm.project.title)
                            .font(.headline)
                        Spacer()
                        Image(systemName: toggle ? "chevron.down" : "chevron.up")
                    }
                }
                .buttonStyle(.plain)
                
                Divider()
                    .background(.white)
                if toggle {
                    ForEach(vm.filterMembers()) { member in
                        Button {
                            
                        } label: {
                            ContactCardView(member: member)
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: toggle)
    }
}

//#Preview {
//    ProjectContactView()
//}
