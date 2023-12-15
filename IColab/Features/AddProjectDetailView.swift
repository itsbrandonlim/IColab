//
//  AddProjectDetailView.swift
//  IColab
//
//  Created by Jeremy Raymond on 10/10/23.
//

import SwiftUI

struct AddProjectDetailView: View {
    @Binding var pageIndex: Int
    @EnvironmentObject var vm: CreateProjectViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create Project")
                .font(.largeTitle.bold())
            VStack(alignment: .center) {
                InputTitleView(title: "Project Title", text: $vm.project.title)
                InputDescriptionView(title: "Project Short Summary", text: $vm.project.desc)
                InputTagsView(tags: $vm.project.tags)
                InputDateView(date: $vm.project.startDate, title: "Input Start Date")
                Spacer()
                ButtonComponent(title: "Next", width: 240) {
                    withAnimation() {
                        if vm.validateProjectDetail() {
                            pageIndex = 1
                        }
                    }
                }
            }
            .padding()
        }
        .alert(isPresented: $vm.showAlert, error: vm.error) { error in
            Button("Dismiss"){
                
            }
        } message: { error in
            Text("\(vm.error?.recoverySuggestion ?? "")")
        }
    }
    

}

//#Preview {
//    AddProjectDetailView()
//}
