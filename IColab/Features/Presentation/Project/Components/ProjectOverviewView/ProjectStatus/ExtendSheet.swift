//
//  ExtendSheet.swift
//  IColab
//
//  Created by Kevin Dallian on 25/10/23.
//

import SwiftUI

struct ExtendSheet: View {
    @EnvironmentObject var vm : ProjectOverviewViewModel
    @State var startDate : Date = Date.now
    @State var endDate : Date = Date.now
    @Binding var showSheet : Bool
    var body: some View {
        VStack{
            Text("Start Date")
                .bold()
            Text(.init("You can only extend for **three** more times. The extend limit is until **08-08-2023**."))
            DatePicker("Extend Start Date", selection: $startDate, displayedComponents: .date)
            DatePicker("Extend End Date", selection: $endDate, displayedComponents: .date)
            ButtonComponent(title: "Confirm", width: 320) {
                vm.extendProject(startDate: startDate, endDate: endDate)
                showSheet = false
            }
        }
    }
}

#Preview {
    ExtendSheet(showSheet: .constant(false))
}
