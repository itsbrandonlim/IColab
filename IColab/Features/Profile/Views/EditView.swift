//
//  EditView.swift
//  IColab
//
//  Created by Kevin Dallian on 20/09/23.
//

import SwiftUI

enum BackgroundType: String {
    case skill = "Skill"
    case education = "Education"
    case experience = "Experience"
}

struct EditView: View {
    @EnvironmentObject var pvm : ProfileViewModel
    var backgroundType : BackgroundType
    var body: some View {
        ScrollView{
            switch backgroundType {
            case .skill:
                ForEach((pvm.account?.accountDetail.skills)!, id: \.self){ skill in
                    Text("Skills")
                }
            case .education:
                ForEach(pvm.account?.accountDetail.educations ?? [], id: \.self) { background in
                    ExperienceDetailView(background: background, editMode: true)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                }
            case .experience:
                ForEach(pvm.account?.accountDetail.experiences ?? [], id: \.self) { background in
                    ExperienceDetailView(background: background, editMode: true)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                }
            }
        }
        .navigationTitle("\(backgroundType.rawValue)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            EditView(backgroundType: .education)
        }
    }
}