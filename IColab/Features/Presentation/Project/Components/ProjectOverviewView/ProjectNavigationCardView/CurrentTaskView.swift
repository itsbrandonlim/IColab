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
            
            if vm.tasks.filter({$0.status == picker}).isEmpty {
                Spacer()
                EmptyDataView(icon: "book.pages", title: "No Tasks listed with status \(picker.rawValue)", desc: "")
                Spacer()
            } else{
                ScrollView {
                    Group {
                        ForEach(0..<vm.tasks.count, id: \.self) { i in
                            if vm.tasks[i].status == picker {
                                TaskCardView(task: vm.tasks[i], toggle: $vm.toggles[i])
                            }
                        }
                    }
                    .padding(4)
                }
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
