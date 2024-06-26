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
    @State var showAlert = false
    var backgroundType : BackgroundType
    var body: some View {
        ZStack{
            ScrollView{
                switch backgroundType {
                case .skill:
                    if pvm.account!.accountDetail.skills.isEmpty {
                        VStack{
                            Text("No skills listed")
                                .font(.title2.bold())
                        }
                    }else {
                        VStack{
                            ForEach(pvm.account!.accountDetail.skills, id: \.self) { skill in
                                SkillEditView(skill: skill)
                                if skill != pvm.account!.accountDetail.skills.last{
                                    Divider()
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                        .padding(.bottom, 10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                    }
                    
                case .education:
                    if pvm.account!.accountDetail.educations.isEmpty {
                        VStack{
                            Text("No Education listed")
                                .font(.title2.bold())
                        }
                    } else {
                        ForEach(pvm.account?.accountDetail.educations ?? [], id: \.self) { background in
                            ExperienceDetailView(showAlert: $showAlert, background: background, editMode: true)
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                        }
                    }
                    
                case .experience:
                    if pvm.account!.accountDetail.experiences.isEmpty {
                        VStack{
                            Text("No Experience listed")
                                .font(.title2.bold())
                        }
                    } else {
                        ForEach(pvm.account?.accountDetail.experiences ?? [], id: \.self) { background in
                            ExperienceDetailView(showAlert: $showAlert, background: background, editMode: true)
                                .padding()
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                        }
                    }
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    NewFormView(backgroundType: backgroundType)
                        .environmentObject(pvm)
                } label: {
                    Image(systemName: "plus")
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
            EditView(backgroundType: .skill)
                .environmentObject(ProfileViewModel())
        }
    }
}
