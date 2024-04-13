//
//  CreateProjectError.swift
//  IColab
//
//  Created by Kevin Dallian on 12/12/23.
//

import Foundation

enum CreateProjectError : Error {
    case titleMissing
    case summaryMissing
    case milestoneMissing
    case goalsMissing(Milestone)
    case taskMissing(Goal)
    case firestoreError(Error)
}

extension CreateProjectError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .titleMissing:
            return NSLocalizedString("Title is not filled", comment: "")
        case .summaryMissing:
            return NSLocalizedString("Short Summary is not filled", comment: "")
        case .milestoneMissing:
            return NSLocalizedString("No role assigned yet", comment: "")
        case .firestoreError(let error):
            return NSLocalizedString(error.localizedDescription, comment: "")
        case .goalsMissing(let milestone):
            return NSLocalizedString("Goal missing in \(milestone.role.rawValue) role", comment: "")
        case .taskMissing(let goal):
            return NSLocalizedString("Task missing in \(goal.name)", comment: "")
        }
        
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .titleMissing:
            return NSLocalizedString("Please fill Title to create project", comment: "")
        case .summaryMissing:
            return NSLocalizedString("Please fill Short Summary to create project", comment: "")
        case .milestoneMissing:
            return NSLocalizedString("Assign roles in the project", comment: "")
        case .firestoreError(let error):
            return NSLocalizedString(error.localizedDescription, comment: "")
        case .goalsMissing(let milestone):
            return NSLocalizedString("Please fill in the goals for \(milestone.role.rawValue) role", comment: "")
        case .taskMissing(let goal):
            return NSLocalizedString("Please fill in tasks for \(goal.name)", comment: "")
        }
    }
}
