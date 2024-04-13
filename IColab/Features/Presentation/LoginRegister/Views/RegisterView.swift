//
//  RegisterView.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 10/2/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var rvm : RegisterViewModel
    var body: some View {
        VStack {
            Spacer()
            Group {
                TextFieldView(input: $rvm.username, icon: "person", text: "Username")
                TextFieldView(input: $rvm.email, icon: "envelope.fill", text: "Email")
                TextFieldView(input: $rvm.password, icon: "key", text: "Password", textfieldStyle: .password)
                TextFieldView(input: $rvm.phoneNumber, icon: "iphone.rear.camera", text: "Phone Number")
                TextFieldView(input: $rvm.region, icon: "flag", text: "Region")
            }
            .padding(.vertical)
            Spacer()
            VStack {
                if rvm.isLoading {
                    Button(action: {}, label: {
                        LoadingView()
                            .frame(width: 320, height: 30)
                    })
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 12))
                    .tint(Color(.purple))
                    .disabled(rvm.isLoading)
                    .padding(.bottom, 10)
                } else{
                    ButtonComponent(title: "Register", width: 320) {
                        rvm.register()
                    }
                    .padding(.bottom, 10)
                }
                Button {
                    rvm.signIn.toggle()
                } label: {
                    Text("Already have an Account? Sign In")
                }
                .buttonStyle(.plain)
            }
            Spacer()
            Spacer()
        }
        .ignoresSafeArea(.keyboard)
        .padding()
        .navigationTitle("Register")
        .alert(isPresented: $rvm.showError, error: rvm.error) { error in
            Button { rvm.isLoading = false } label: { Text("Dismiss") }
        } message: { error in
            Text("\(error.recoverySuggestion ?? "Unknown Error Occured")")
        }
        
        .navigationDestination(isPresented: $rvm.signIn, destination: {
            LoginView(lvm: LoginViewModel(showSignIn: $rvm.showSignIn))
        })
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.large)
    }
}
