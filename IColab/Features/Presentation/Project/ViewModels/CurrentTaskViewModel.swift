//
//  CurrentTaskViewModel.swift
//  IColab
//
//  Created by Jeremy Raymond on 06/10/23.
//

import Foundation

class CurrentTaskViewModel: ObservableObject {
    @Published var project: Project
    @Published var goal: Goal!
    @Published var tasks: [Task] = []
    @Published var toggles: [Bool] = []
    @Published var isOwner : Bool = false
    
    let updateProjectUseCase = UpdateProjectUseCase()
    
    init(project : Project, uid: String){
        self.project = project
        self.goal = getGoal(uid: uid)
        self.tasks = goal.tasks
        self.initToggle()
        self.isOwner = self.validateOwner()
    }
    
    func getGoal(uid: String) -> Goal {
        let goals = project.milestones[0].goals
        
        return goals.first { goal in
            goal.id == uid
        }!
    }
    
    private func initToggle() {
        for task in tasks {
            if task.status == .notCompleted {
                toggles.append(false)
            }
            else {
                toggles.append(true)
            }
        }
    }
    
    func submitTasks() {
        for (index, _) in self.tasks.enumerated() {
            if toggles[index] == true && self.tasks[index].status == .notCompleted {
                let indexGoal = project.milestones[0].goals.firstIndex(where: {$0.id == self.goal.id})
                project.milestones[0].goals[indexGoal!].tasks[index].setStatus(status: .onReview)
                saveProjectToFirestore()
                
                self.goal = project.milestones[0].goals[indexGoal!]
                self.tasks = self.goal.tasks
                self.objectWillChange.send()
                
            }
        }
    }
    
    func validateTask() {
        for (index, _) in self.tasks.enumerated() {
            if toggles[index] == true && self.tasks[index].status == .onReview {
                let indexGoal = project.milestones[0].goals.firstIndex(where: {$0.id == self.goal.id})
                project.milestones[0].goals[indexGoal!].tasks[index].setStatus(status: .completed)
                saveProjectToFirestore()
                
                self.goal = project.milestones[0].goals[indexGoal!]
                self.tasks = self.goal.tasks
                self.objectWillChange.send()
            }
        }
    }
    
    func validateOwner() -> Bool {
        AccountManager.shared.account?.id == project.owner
    }
    
    private func saveProjectToFirestore() {
        updateProjectUseCase.call(project: project) { error in
            if let error = error {
                print("Error saving project to firestore : \(error.localizedDescription)")
            }
        }
    }
}
