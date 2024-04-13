//
//  CreateTaskView.swift
//  IColab
//
//  Created by Jeremy Raymond on 07/10/23.
//

import SwiftUI

struct CreateTaskView: View {
    @EnvironmentObject var vm: EditProjectViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var title: String = ""
    
    var body: some View {
        VStack {
            InputTitleView(title: "Task", text: $title)
            ButtonComponent(title: "Submit", width: 240) {
                vm.tasks.append(Task(title: title, status: .notCompleted))
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        
    }
}

#Preview {
    CreateTaskView()
}
