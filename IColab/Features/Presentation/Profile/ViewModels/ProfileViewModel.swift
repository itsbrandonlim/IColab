//
//  ProfileViewModel.swift
//  IColab
//
//  Created by Kevin Dallian on 11/09/23.
//

import Foundation
import SwiftUI

class ProfileViewModel : ObservableObject {
    @Published var account : Account?
    @Published var pickerSelection : PickerItem = .overview
    @Published var showEdit : Bool = false
    @Published var loggedInAccountIsViewed : Bool = false
    @Published var update = AddAccountDetailUseCase()
    var accountDetailsConstant = FireStoreConstant.AccountDetailConstants()
    let pickerItems : [PickerItem] = [.overview, .portofolio]
    init(){
        self.account = getAccount()
        if account == AccountManager.shared.account {
            loggedInAccountIsViewed = true
        }
    }
    
    init(accountDetail: AccountDetail){
        self.account = Account(email: "", password: "", accountDetail: accountDetail)
    }
    private func getAccount() -> Account?{
        return AccountManager.shared.account
    }
    
    public func getBackgroundIndex(background : Background) -> Int {
        var index = -1
        if background is Experience {
            index = account!.accountDetail.experiences.firstIndex(of: background as! Experience) ?? -1
        }else if background is Education{
            index = account!.accountDetail.educations.firstIndex(of: background as! Education) ?? -1
        }
        return index
    }
    
    public func saveBackground(background : Background, index : Int) {
        if index != -1{
            if background is Experience {
                account?.accountDetail.experiences[index] = background as! Experience
            } else if background is Education {
                account?.accountDetail.educations[index] = background as! Education
            }
        }
        withAnimation {
            objectWillChange.send()
        }
        self.saveToFireStore()
    }
    
    public func addBackground(background : Background) {
        if background is Experience {
            account?.accountDetail.addExperiences(experience: background as! Experience)
        } else if background is Education {
            account?.accountDetail.addEducation(education: background as! Education)
        }
        withAnimation {
            objectWillChange.send()
        }
        self.saveToFireStore()
    }
    
    public func deleteBackground(background : Background) {
        var index = 0
        if background is Experience {
            index = account!.accountDetail.experiences.firstIndex(of: background as! Experience) ?? 0
            account?.accountDetail.removeExperiences(idx: index)
        }else if background is Education{
            index = account!.accountDetail.educations.firstIndex(of: background as! Education) ?? 0
            account?.accountDetail.removeEducation(idx: index)
        }
        withAnimation {
            objectWillChange.send()
        }
        self.saveToFireStore()
    }
    
    public func getSkillIndex(skill: String) -> Int{
        return account?.accountDetail.skills.firstIndex(of: skill) ?? -1
    }
    
    public func addSkills(skill : String){
        account?.accountDetail.skills.append(skill)
        objectWillChange.send()
        self.saveToFireStore()
    }
    
    public func editSkills(skill : String, index : Int){
        account?.accountDetail.skills[index] = skill
        self.saveToFireStore()
        withAnimation {
            objectWillChange.send()
        }
        
    }
    
    public func deleteSkills(skill : String){
        let index = account?.accountDetail.skills.firstIndex(of: skill) ?? -1
        if index != -1 {
            account?.accountDetail.removeSkill(idx: index)
            withAnimation {
                objectWillChange.send()
            }
        }
        self.saveToFireStore()
    }
    
    public func editProfile(name: String, bankAccount: String, region: String, desc: String){
        account?.accountDetail.name = name
        account?.accountDetail.location = region
        account?.accountDetail.bankAccount = bankAccount
        account?.accountDetail.desc = desc
        self.saveToFireStore()
        objectWillChange.send()
    }
    
    public func saveToFireStore(){
        update.call(accountDetail: self.account!.accountDetail, id: AuthenticationManager.shared.getLoggedInUser()!.uid) { error in
            print("Error saving to firestore: \(String(describing: error?.localizedDescription))")
        }
    }
}
