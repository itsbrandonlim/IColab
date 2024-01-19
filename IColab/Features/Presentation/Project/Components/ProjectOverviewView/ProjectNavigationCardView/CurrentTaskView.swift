//
//  CurrentTaskView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct CurrentTaskView: View {
    @StateObject var vm: CurrentTaskViewModel
    @State var picker: TaskStatus = .notCompleted
    
    var body: some View {
        VStack {
            Picker("Task Type", selection: $picker) {
                ForEach(TaskStatus.allCases, id: \.self) { picker in
                    Text(picker.rawValue).tag(picker)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            if !vm.tasks.filter({$0.key.status == picker}).isEmpty {
                ScrollView {
                    Group {
                        ForEach(Array(vm.tasks), id: \.key) { (key, value) in
                            if key.status == picker { // Filter within the ForEach
                                TaskCardView(task: key, toggle: Binding<Bool>(
                                    get: { value },
                                    set: { newValue in vm.tasks[key] = newValue }
                                ))
                            }
                        }
                    }
                    .padding(4)
                }
            } else{
                Spacer()
                EmptyDataView(icon: "book.pages", title: "No Tasks listed with status \(picker.rawValue)", desc: "")
                Spacer()
            }
            
            if vm.isOwner {
                if picker == .onReview {
                    ButtonComponent(title: "Validate", width: 360) {
                        vm.validateTask()
                    }
                }
            }
            else {
                if picker == .notCompleted {
                    ButtonComponent(title: "Submit", width: 360) {
                        vm.submitTasks()
                    }
                }
            }
        }
        .padding()
    }
}

//struct CurrentTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentTaskView()
//            .preferredColorScheme(.dark)
//    }
//}
