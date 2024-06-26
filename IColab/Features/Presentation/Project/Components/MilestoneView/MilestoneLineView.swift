//
//  MilestoneLineView.swift
//  IColab
//
//  Created by Jeremy Raymond on 28/09/23.
//

import SwiftUI

struct VerticalStepIndicator: View {
    @ObservedObject var vm: EditProjectViewModel
    
    var role: Role
    let currentStepIndex: Int

    var body: some View {
        NavigationStack {
            ZStack {
                HStack {
                    Rectangle()
                        .frame(width: 4)
                        .padding(.leading, 14)
                        .padding(.vertical, 82)
                        .foregroundColor(.purple)
                    Spacer()
                }
                VStack {
                    ForEach(0..<vm.getMilestone(role: role).goals.count, id: \.self) { index in
                        HStack {
                            if !(index <= currentStepIndex) {
                                Circle()
                                    .stroke(
                                        .purple,
                                        lineWidth: 4
                                    )
                                    .background(.black)
                                    .cornerRadius(99)
                                    .frame(width: 32)
                            }
                            else {
                                Circle()
                                    .frame(width: 32)
                                    .foregroundColor(.purple)
                            }
                            NavigationLink {
                                MilestoneDetailView(milestone: vm.getMilestone(role: role), goal: vm.getMilestone(role: role).goals[index])
                                    .environmentObject(vm)
                            } label: {
                                MilestoneCardView(goal: vm.getMilestone(role: role).goals[index])
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct MilestoneLineView: View {
    @ObservedObject var vm: EditProjectViewModel
    var role: Role
    let currentStepIndex = 1 // Set the current step index here

    var body: some View {
        VStack {
            if vm.getMilestone(role: role).goals.isEmpty {
                Image(systemName: "target")
                    .font(.largeTitle)
                Text("No goals yet, add some")
                    .font(.title3)
            }
            else {
                VerticalStepIndicator(vm: vm, role: role, currentStepIndex: currentStepIndex)
            }
            if vm.project.owner == AccountManager.shared.account?.id {
                ButtonComponent(title: "Add Goals", width: 330) {
                    vm.nextView = true
                }
            }
        }
        .navigationDestination(isPresented: $vm.nextView) {
            AddGoalView(vm: vm, isEdit: false, role: role)
        }
    }
}

//#Preview {
//    MilestoneLineView(milestone: Mock.projects[0].milestones[0])
//}
