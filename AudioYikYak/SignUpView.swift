//
//  SignUpView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var isShowingSignUpView: Bool
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @Binding var password: String
    @State var errorMessage: String
    
    var body: some View {
        VStack {
            
            XDismissButton(isShowingModal: $isShowingSignUpView)
            
            VStack(spacing: 20) {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                Button {
                    Task { await signUp() }
                } label: {
                    Label("Sign Up", systemImage: "arrow.forward")
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .controlSize(.large)
            }
            .padding()
            
            Spacer()
            
            Text("\(errorMessage)")
        }
    }
    
    func signUp () async {
        var usernameExists = await checkIfUsernameExists(username: self.username)
        
        if usernameExists {
            self.errorMessage = "User already exists"
            return
        }
        
        addUser(username: self.username, password: self.password, bio: "")
        
        isShowingSignUpView = false
        isLoggedIn = true
    }
}
