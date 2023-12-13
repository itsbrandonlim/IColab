//
//  UpdateProjectUseCase.swift
//  IColab
//
//  Created by Kevin Dallian on 13/12/23.
//

import Foundation

struct UpdateProjectUseCase {
    var repository = FireStoreRepository()
    
    public func call(project: Project, completion: @escaping (Error?) -> Void) {
        repository.updateProject(project: project, completion: completion)
    }
}
