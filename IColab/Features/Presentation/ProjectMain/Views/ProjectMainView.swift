//
//  ProjectMainView.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 10/2/23.
//

import SwiftUI

struct ProjectMainView: View {
    @StateObject var vm: ProjectMainViewModel = ProjectMainViewModel()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Projects")
                        .font(.largeTitle)
                        .bold()
                    NavigationLink {
                        CreateProjectView(vm: CreateProjectViewModel(needRefresh: $vm.needRefresh))
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                
                switch vm.picker {
                    case .projectOwned:
                    SearchView(
                        array: $vm.projectOwned,
                        vm: SearchViewModel(array: vm.projectOwned),
                        filterView: AnyView(
                            Text("Project Main Filter")
                        )
                    )
                    case .projectJoined:
                    SearchView(
                        array: $vm.projectJoined,
                        vm: SearchViewModel(array: vm.projectJoined),
                        filterView: AnyView(
                            Text("Project Main Filter")
                        )
                    )
                }
                Picker("Project Picker", selection: $vm.picker) {
                    ForEach(ProjectMainViewPicker.allCases, id: \.self) { picker in
                        Text(picker.rawValue).tag(picker)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.vertical)
                if vm.getProjectsByType(picker: vm.picker).isEmpty{
                    VStack(spacing: 10){
                        Spacer()
                        Image(systemName: "book.closed")
                            .font(.system(size: 64))
                        Text("No Projects to be Shown")
                            .font(.title3.bold())
                        Spacer()
                        Spacer()
                    }
                }
                ScrollView {
                    ForEach(vm.getProjectsByType(picker: vm.picker)) { project in
                        NavigationLink {
                            ProjectOverviewView(vm: ProjectOverviewViewModel(project: project))
                                .environmentObject(vm)
                        } label: {
                            ProjectMainCardView(project: project)
                        }
                    }
                }
            }
            
        }
        .padding()
    }
}
//
//#Preview {
//    ProjectMainView()
//        .preferredColorScheme(.dark)
//}

