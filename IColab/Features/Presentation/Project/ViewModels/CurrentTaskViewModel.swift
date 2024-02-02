//
//  CurrentTaskViewModel.swift
//  IColab
//
//  Created by Jeremy Raymond on 06/10/23.
//

import Foundation

class CurrentTaskViewModel: ObservableObject {
    @Published var project: Project
    @Published var selectedRole : Role!
    @Published var goal: Goal!
    @Published var tasks: [Task : Bool] = [:]
    @Published var isOwner : Bool = false
    
    let updateProjectUseCase = UpdateProjectUseCase()
    let setPaymentUseCase = SetPaymentUseCase()
    
    init(project : Project, goal : Goal){
        self.project = project
        self.goal = goal
        self.tasks = initToggle(tasks: goal.tasks)
        self.isOwner = self.validateOwner()
    }
    
    private func initToggle(tasks : [Task]) -> [Task : Bool] {
        var tasksWithToggle : [Task : Bool] = [:]
        for task in tasks {
            if task.status == .notCompleted {
                tasksWithToggle[task] = false
            }
            else {
                tasksWithToggle[task] = true
            }
        }
        return tasksWithToggle
    }
    
    func submitTasks() {
        let milestoneIndex = project.milestones.firstIndex(where: {$0.goals.contains(goal)}) ?? 0
        let goalIndex = project.milestones[milestoneIndex].goals.firstIndex(of: goal) ?? 0
        
        tasks.forEach { (task: Task, isTrue: Bool) in
            if isTrue {
                let taskIndex = project.milestones[milestoneIndex].goals[goalIndex].tasks.firstIndex(of: task) ?? 0
                project.milestones[milestoneIndex].goals[goalIndex].tasks[taskIndex].setStatus(status: .onReview)
            }
        }
        saveProjectToFirestore()
        self.goal = project.milestones[milestoneIndex].goals[goalIndex]
        self.tasks = initToggle(tasks: self.goal.tasks)
        self.objectWillChange.send()
    }
    
    func validateTask() {
        let milestoneIndex = project.milestones.firstIndex(where: {$0.goals.contains(goal)}) ?? 0
        let goalIndex = project.milestones[milestoneIndex].goals.firstIndex(of: goal) ?? 0
        
        tasks.forEach { (task: Task, isTrue: Bool) in
            if isTrue && task.status == .onReview {
                let taskIndex = project.milestones[milestoneIndex].goals[goalIndex].tasks.firstIndex(of: task) ?? 0
                project.milestones[milestoneIndex].goals[goalIndex].tasks[taskIndex].setStatus(status: .completed)
            }
        }
        
        if project.milestones[milestoneIndex].goals[goalIndex].tasks.allSatisfy({$0.status == .completed}) {
            project.milestones[milestoneIndex].goals[goalIndex].isAchieved = true
        }
        
        saveProjectToFirestore()
        self.goal = project.milestones[milestoneIndex].goals[goalIndex]
        self.tasks = initToggle(tasks: self.goal.tasks)
        self.objectWillChange.send()
        
        self.checkIfGoalFinished()
    }
    
    func checkIfGoalFinished() {
        let milestoneIndex = project.milestones.firstIndex(where: {$0.goals.contains(goal)}) ?? 0
        let goalIndex = project.milestones[milestoneIndex].goals.firstIndex(of: goal) ?? 0
        
        if tasks.count == tasks.map({$0.key.status == .completed}).count {
            print("All tasks completed")
            for member in project.members {
                do {
                    try self.setPaymentUseCase.call(payment: Payment(amount: 1234, owner: project.owner ?? "Owner ID not found", worker: member.workerID, project: project.id, goal: project.milestones[milestoneIndex].goals[goalIndex].id))
                    self.objectWillChange.send()
                }
                catch {
                    print("Failed creating Payment")
                }
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
