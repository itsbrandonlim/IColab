//
//  ProfileFormView.swift
//  IColab
//
//  Created by Kevin Dallian on 18/10/23.
//

import SwiftUI

struct ProfileFormView: View {
    @EnvironmentObject var pvm : ProfileViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var name : String
    @State var bankAccount : String
    @State var region : String
    @State var desc : String
    var body: some View {
        VStack{
            FormTextField(title: "Name", textField: $name)
                .padding(.top, 20)
            FormTextField(title: "Region", textField: $region)
            FormTextField(title: "Description", textField: $desc)
            FormTextField(title: "Bank Account", textField: $bankAccount)
            Spacer()
            ButtonComponent(title: "Save", width: 320) {
                pvm.editProfile(name: name, bankAccount: bankAccount, region: region, desc: desc)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .ignoresSafeArea(.keyboard)
        .padding(.horizontal, 20)
        .navigationTitle("Edit Profile")
    }
}

#Preview {
    NavigationStack{
        ProfileFormView(name: "Kevin", bankAccount: "BankAccount", region: "Indonesia", desc: "Description")
    }
}
