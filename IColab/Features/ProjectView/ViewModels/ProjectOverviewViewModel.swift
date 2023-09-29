//
//  ProjectOverviewViewModel.swift
//  IColab
//
//  Created by Jeremy Raymond on 26/09/23.
//

import Foundation

class ProjectOverviewViewModel: ObservableObject {
    @Published var account: Account?
    
    init(uid: String){
        self.account = getAccount(uid: uid)
    }
    
    private func getAccount(uid: String) -> Account?{
        return Mock.accounts.first { account in
            account.id == uid
        }
    }
    
    func getTestProject() -> Project {
        return (account?.projectsOwned![0])!
    }
    
    func editProjectDetail(title: String, summary: String, tags: [String], index: Int) {
        var project = account!.projectsOwned![0]
        
        account!.projectsOwned![0] = Project(title: title, role: project.role, requirements: project.requirements, tags: tags, startDate: project.startDate, endDate: project.endDate, desc: summary, milestones: project.milestones)
    }
}
