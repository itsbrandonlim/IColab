//
//  LoginView.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 10/2/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var lvm : LoginViewModel
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Group {
                    TextFieldView(input: $lvm.email, icon: "person", text: "Email")
                    TextFieldView(input: $lvm.password, icon: "key", text: "Password", textfieldStyle: .password)
                }
                .padding(.vertical)
                Spacer()
                
                VStack {
                    Button {
                        lvm.login()
                    } label: {
                        if lvm.isLoading {
                            LoadingView()
                                .frame(width: 330, height: 20)
                                .padding(.vertical, 10)
                                .border(.primary)
                        } else{
                            Text("Sign In")
                                .frame(width: 330, height: 20)
                                .padding(.vertical, 10)
                                .border(.primary)
                        }
                    }
                    .disabled(lvm.isLoading)
                    .buttonStyle(.plain)
                    Text("Forgot Password?")
                    ButtonComponent(title: "Create Account", width: 320) {
                        lvm.createAccount.toggle()
                    }
                }
                Spacer()
                Spacer()
            }
            .navigationTitle("Login")
            .padding()
            .alert(isPresented: $lvm.showAlert, error: lvm.error) { error in
                Button("Dismiss"){
                    print("Dismiss")
                }
            } message: { error in
                Text("\(lvm.error?.recoverySuggestion ?? "")")
            }
            .navigationDestination(isPresented: $lvm.createAccount) {
                RegisterView(rvm: RegisterViewModel(showSignIn: $lvm.showSignIn))
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.large)
    }
        
}


