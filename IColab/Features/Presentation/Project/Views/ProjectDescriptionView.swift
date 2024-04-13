//
//  ProjectDescriptionView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct ProjectDescriptionView: View {
    @EnvironmentObject var vm: ProjectOverviewViewModel
    
    var project: Project
    
    var body: some View {
        VStack {
            VStack {
                HStack{
                    DetailCard(
                        detailCardType: .cardwithlogo,
                        symbol: "clock",
                        title: "Start Date",
                        caption: "\(project.startDate.formatted(date: .numeric, time: .omitted))")
                    DetailCard(
                        detailCardType: .cardwithlogo,
                        symbol: "clock.fill",
                        title: "End Date",
                        caption: "\(project.endDate.formatted(date: .numeric, time: .omitted))"
                    )
                }
                HStack{
                    DetailCard(
                        detailCardType: .cardwithlogo,
                        symbol: "dollarsign",
                        title: "Total Earning",
                        caption: "Rp \(project.getTotalMilestone().formatted(.number))"
                    )
                }
            }
            
            DetailCard(detailCardType: .description, title: "Job Description", caption: "\(project.desc)")
                .padding(.vertical)
            
            VStack(alignment: .leading) {
                Text("Members")
                    .font(.headline)
                ForEach(vm.getExistingRoles(), id: \.self) { role in
                    MemberListView(role: role, count: vm.getMemberCount(role: role))
                }
            }
            .padding()
            .background(Color("gray"))
            
            Spacer()
        }
        .navigationTitle("Project Description")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.vertical, 36)
        .padding()
        
        
    }
}

struct ProjectDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDescriptionView(project: Mock.projects[0])
            .preferredColorScheme(.dark)
            .environmentObject(ProjectOverviewViewModel(project: Mock.projects[0]))
    }
}
