//
//  AddGoalView.swift
//  IColab
//
//  Created by Jeremy Raymond on 07/10/23.
//

import SwiftUI

struct AddGoalView: View {
    @ObservedObject var vm: EditProjectViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var isEdit : Bool
    
    var role: Role
    
    var body: some View {
        VStack {
            InputTitleView(title: "Goal Title", text: $vm.title)
            InputNumberView(title: "Nominal", nominal: $vm.nominal)
            InputDescriptionView(title: "Goal's Description", text: $vm.desc)
            InputDateView(date: $vm.dueDate)
            InputTaskView()
            ButtonComponent(title: "Add Goal", width: 320) {
                vm.addGoal(role: role, isEdit: isEdit)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .ignoresSafeArea(.keyboard)
        .padding(.horizontal)
        .environmentObject(vm)
        .navigationTitle("Add Goal")
    }
}

//#Preview {
//    AddGoalView()
//}
