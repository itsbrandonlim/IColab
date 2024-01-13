//
//  MilestonesView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct MilestonesView: View {
    @StateObject var vm: EditProjectViewModel
    
    @State var picker: Role
    
    var body: some View {
        NavigationStack {
            Picker("Milestone Picker", selection: $picker) {
                ForEach(vm.milestones) { milestone in
                    Text(milestone.role.rawValue).tag(milestone.role)
                }
            }
            .pickerStyle(.segmented)
            ScrollView {
                VStack {
                    HStack {
                        MilestoneInfoView(title: "Total Milestone", value: "\(vm.getMilestone(role: picker).goals.count)", measurement: "Milestone")
                        Divider()
                            .frame(height: 32)
                        MilestoneInfoView(title: "Average Length", value: "2.2", measurement: "Days")
                        Divider()
                            .frame(height: 32)
                        MilestoneInfoView(title: "Average Payment", value: "\(vm.getAveragePayment(role: picker).formatted(.currency(code: "IDR")))", measurement: "")
                    }
                    .padding()
                    .background(Color("gray"))
                    .cornerRadius(12)
                    MilestoneLineView(vm: vm, role: picker)
                }
            }
            .navigationTitle("Milestone")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddGoalView(vm: vm, role: picker)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }

                }
            }
        }
        
    }
}

//struct MilestonesView_Previews: PreviewProvider {
//    static var previews: some View {
//        MilestonesView()
//            .preferredColorScheme(.dark)
//    }
//}
