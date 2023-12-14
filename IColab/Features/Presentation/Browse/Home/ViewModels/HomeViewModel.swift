//
//  HomeViewModel.swift
//  IColab
//
//  Created by Kevin Dallian on 02/09/23.
//

import Foundation
import FirebaseFirestore

class HomeViewModel : ObservableObject{
    @Published var projects : [Project] = []
    @Published var searchText : String = ""
    @Published var searchPressed : Bool = false
    @Published var filters : [String] = []
    var fetchProject = FetchCollectionUseCase()
    
    public func getProjects(completion: @escaping ()->Void){
        let projectConstants = FireStoreConstant.ProjectConstants()
        var allProjects : [Project] = []
        fetchProject.call(collectionName: projectConstants.collectionName) { querySnapShot in
            querySnapShot.documents.forEach { doc in
                let project = Project.decode(from: doc.data())
                allProjects.append(project)
            }
            let filteredProjects = allProjects.filter { project in
                project.owner != AccountManager.shared.account?.id
            }
            self.projects = filteredProjects
            self.objectWillChange.send()
            completion()
        }
    }
    
    private func getSearchProjects(searchTitle: String) -> [Project] {
        if searchTitle.isEmpty{
            return Mock.projects
        }
        let allProjects = Mock.projects
        let filteredProjects = allProjects.filter { project in
            let projectTitleLowercased = project.title.lowercased()
            return projectTitleLowercased.contains(searchTitle.lowercased())
        }
        return filteredProjects
    }
    
    public func searchProject(searchTitle: String) {
        self.projects = getSearchProjects(searchTitle: searchTitle)
    }
}
