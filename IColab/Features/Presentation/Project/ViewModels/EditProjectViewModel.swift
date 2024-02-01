//
//  EditProjectViewModel.swift
//  IColab
//
//  Created by Jeremy Raymond on 07/10/23.
//

import Foundation

class EditProjectViewModel: ObservableObject {
    @Published var project: Project
    @Published var milestones: [Milestone]
    
    init(project: Project, initializeGoal: Bool = false, goal : Goal? = nil) {
        self.project = project
        self.milestones = project.milestones
    }
    
    @Published var title: String = ""
    @Published var nominal: Int = 0
    @Published var desc: String = ""
    @Published var dueDate: Date = Date.now
    @Published var tasks: [Task] = []
    @Published var nextView : Bool = false
    let updateProjectUseCase = UpdateProjectUseCase()
    var setPayment = SetPaymentUseCase()
    
    func initializeGoal(goal : Goal) {
        self.title = goal.name
        self.nominal = goal.nominal
        self.desc = goal.desc
        self.dueDate = goal.endDate
        self.tasks = goal.tasks
    }
    
    func addTask(title: String) {
        let task = Task(title: title)
        tasks.append(task)
        self.objectWillChange.send()
    }
    
    func deleteTask(task: Task) {
        let index = tasks.firstIndex(of: task)!
        tasks.remove(at: index)
        self.objectWillChange.send()
    }
    
    func getMilestone(role: Role) -> Milestone {
        let index = self.project.milestones.firstIndex(where: {$0.role == role})
        
        return self.project.milestones[index!]
    }
    
    func getAveragePayment(role : Role) -> Double {
        let goals = getMilestone(role: role).goals
        
        return Double(goals.map({$0.nominal}).reduce(0, +) / goals.count)
    }
    
    public func setPayment(amount: Double, owner: String, worker: String, project: String, goal: String) {
        do {
            try self.setPayment.call(payment: Payment(amount: amount, owner: "Test Owner", worker: "Test Worker", project: project, goal: goal))
            self.objectWillChange.send()
        }
        catch {
            print("Failed creating Payment")
        }
    }
    
    func addGoal(role: Role, isEdit: Bool) {
        let index = self.milestones.firstIndex(where: {$0.role == role})
        
        project.milestones[index!].goals.append(Goal(name: title, nominal: nominal, desc: desc, endDate: dueDate, isAchieved: false, tasks: tasks))
        
        if isEdit {
            updateProjectToFirestore()
        }
        self.objectWillChange.send()
    }
    
    func editGoal(role: Role, goal: Goal, isEdit : Bool) {
        let index = self.milestones.firstIndex(where: {$0.role == role})
        let goalIndex = self.milestones[index!].goals.firstIndex(where: {$0.id == goal.id})
        
        let goal = project.milestones[index!].goals[goalIndex!]
        
        project.milestones[index!].goals[goalIndex!] = Goal(name: title, nominal: nominal, desc: desc, endDate: dueDate, isAchieved: goal.isAchieved, tasks: tasks)
        
        if isEdit {
            updateProjectToFirestore()
        }
        self.milestones = self.project.milestones
        
        self.objectWillChange.send()
    }
    
    func deleteGoal(role: Role, goal: Goal, isEdit : Bool) {
        let index = self.milestones.firstIndex(where: {$0.role == role})
        let goalIndex = self.milestones[index!].goals.firstIndex(where: {$0.id == goal.id})!
        
        project.milestones[index!].goals.remove(at: goalIndex)
        if isEdit {
            updateProjectToFirestore()
        }
        self.milestones = self.project.milestones
        self.objectWillChange.send()
    }
    
    func updateProjectToFirestore() {
        updateProjectUseCase.call(project: project) { error in
            if let error = error {
                print("Error updating project to firestore :\(error.localizedDescription)")
            }
        }
    }
}
