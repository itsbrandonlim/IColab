//
//  MockProjects.swift
//  IColab
//
//  Created by Jeremy Raymond on 01/10/23.
//

import Foundation

struct MockProjects: Randomizeable {
    typealias Element = Project
    
    static var title: [String] = [
        "Front-end Project",
        "Back-end Project",
        "Vision Project",
        "Database Project",
        "Design Project",
        "Cloud Project",
        "IoT Project",
        "Create ML Project",
        "Augmented Reality Project"
    ]
    
    static var array: [Project] =
        MockProjects.initArray(count: title.count) {
            Project(
                title: title.randomElement()!,
                owner: "Owner",
                members: MockMembers.array,
                role: Role.allCases.randomElement()!.rawValue,
                requirements: ["3 years SwiftUI experience", "3 years UIKit experience"],
                tags: ["SwiftUI", "CoreML", "Vision"],
                startDate: Date.now,
                endDate: Calendar.current.date(byAdding: .day, value: 5, to: Date.now)!,
                desc: "Lorem ipsum dolor sit amet",
                milestones: MockMilestones.array,
                projectState: ProjectState.allCases.randomElement()!
            )
        }
    
    
    static func addProjects() -> [Project] {
        return MockProjects.array
    }
}
