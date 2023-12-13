//
//  AccountManager.swift
//  IColab
//
//  Created by Kevin Dallian on 10/10/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class AccountManager : ObservableObject {
    static var shared = AccountManager()
    
    private init(){}

    @Published var account : Account?
    var fetch = FetchCollectionUseCase()
    var fetchDocument = FetchDocumentFromIDUseCase()
    var detailConstants = FireStoreConstant.AccountDetailConstants()
    
    public func getAccount() {
        if let user = Auth.auth().currentUser {
            fetchDocument.call(collectionName: detailConstants.collectionName, id: user.uid) { doc in
                if let document = doc.data(){
                    let name = document[self.detailConstants.name] as! String
                    let phoneNumber = document[self.detailConstants.phoneNumber] as! String
                    let bankAccount = document[self.detailConstants.bankAccount] as! String
                    let desc = document[self.detailConstants.desc] as! String
                    let location = document[self.detailConstants.location] as! String
                    let skills = document[self.detailConstants.skills] as! [String]
                    
                    var educations : [Education] = []
                    let educationsData = document[self.detailConstants.educations]
                    educations = Education.decode(from: educationsData as? [[String : Any]] ?? [[:]])
                    var experiences : [Experience] = []
                    let experiencesData = document[self.detailConstants.experiences]
                    experiences = Experience.decode(from: experiencesData as? [[String : Any]] ?? [[:]])
                    
                    let accountDetail = AccountDetail(name: name, desc: desc, location: location, bankAccount: bankAccount, phoneNumber: phoneNumber, skills: skills, educations: educations, experiences: experiences, projectsOwned: [], projectsJoined: [], notifications: [], chats: [])
                    self.account = Account(email: user.email!, password: "", accountDetail: accountDetail)
                }
            }
        }
    }
    
    public func setAccount(account: Account) {
        self.account = account
        self.objectWillChange.send()
    }
    
    public func logout(){
        account = nil
        AuthenticationManager.shared.logoutUser()
        self.objectWillChange.send()
    }
}
