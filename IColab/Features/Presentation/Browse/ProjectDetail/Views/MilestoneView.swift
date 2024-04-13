//
//  MilestoneView.swift
//  IColab
//
//  Created by Kevin Dallian on 05/09/23.
//

import SwiftUI

struct MilestoneView: View {
    @State var milestones : [Milestone]
    @State var role : Role
    
    init(milestones: [Milestone], role: Role) {
        self.milestones = milestones
        self.role = role
    }
    
    var allExistingRoles : [Role] {
        let allRoles = milestones.map { $0.role }
        return Array(Set(allRoles))
    }
    
    var body: some View {
        ScrollView{
            HStack{
                Text("Role")
                    .font(.title2).bold()
                Spacer()
                Picker("Role", selection: $role) {
                    ForEach(allExistingRoles, id : \.self){ role in
                        Text(role.rawValue)
                    }
                }
            }
            .padding(.horizontal, 30)
            MilestoneDetailCard(milestoneDetailCardType: .overview, milestones: filterMilestone())
            MilestoneDetailCard(milestoneDetailCardType: .detail, milestones: filterMilestone())
                .padding(.horizontal, 15)
        }
    }
    
    func filterMilestone() -> [Milestone] {
       let filteredMilestones = self.milestones.filter({ milestone in
            milestone.role == self.role
        })
        return filteredMilestones
    }
}

struct MilestoneView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneView(milestones: Mock.projects[0].milestones, role: .backend)
    }
}
