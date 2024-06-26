//
//  CreateProjectView.swift
//  IColab
//
//  Created by Jeremy Raymond on 09/10/23.
//

import SwiftUI

struct CreateProjectView: View {
    @StateObject var vm: CreateProjectViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var pageIndex: Int = 0

    
    var body: some View {
        VStack {
            if pageIndex == 0 {
                AddProjectDetailView(pageIndex: $pageIndex)
                    .transition(.backslide)
            }
            else if pageIndex == 1 {
                PickMemberView(pageIndex: $pageIndex)
                    .padding()
                    .transition(.backslide)
                ButtonComponent(title: "Submit", width: 240) {
                    if vm.createProject() {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                .transition(.backslide)
            }
        }
        .environmentObject(vm)
        .padding()
    }
}
//
//#Preview {
//    CreateProjectView()
//}
