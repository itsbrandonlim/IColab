//
//  GroupedContactView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct GroupedContactView: View {
    var projects: [Project]
    
    var members: [Account] = []
    
    var body: some View {
        VStack {
            ForEach(projects) { project in
                ProjectContactView(vm: ProjectContactViewModel(project: project))
            }
        }
        
    }
}

struct GroupedContactView_Previews: PreviewProvider {
    static var previews: some View {
        GroupedContactView(projects: [])
    }
}
