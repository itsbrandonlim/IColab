//
//  EditProjectView.swift
//  IColab
//
//  Created by Jeremy Raymond on 26/09/23.
//

import SwiftUI

struct EditProjectView: View {
    @ObservedObject var vm: ProjectOverviewViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var title: String = ""
    @State var summary: String = ""
    @State var tags: [String] = ["HealthKit"]
    var body: some View {
        VStack {
            VStack {
                InputTitleView(title: "Project Title", text: $title)
                InputDescriptionView(title: "Project Short Summary", text: $summary)
                InputTagsView(tags: $tags)
                InputDateView(date: $vm.project.startDate, title: "Input Start Date")
                InputDateView(date: $vm.project.endDate, title: "Input End Date")
            }
            .padding()
            
            ButtonComponent(title: "Submit", width: 320) {
                vm.editProjectDetail(title: title, summary: summary, tags: tags, startDate: vm.project.startDate, endDate: vm.project.endDate)
                
                vm.objectWillChange.send()
                self.presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
        .padding()
        .onAppear {
            self.title = vm.project.title
            self.summary = vm.project.desc
            self.tags = vm.project.tags
        }
    }
}

#Preview {
    EditProjectView(vm: ProjectOverviewViewModel(project: Project(title: "", role: "", startDate: Date.now, endDate: Date.now, desc: "", milestones: [])))
        .preferredColorScheme(.dark)
}
