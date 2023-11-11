//
//  LoginView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var isShowingLoginView: Bool
    @Binding var isLoggedIn: Bool
    @Binding var username: String
    @Binding var password: String
    @State var errorMessage: String
    
    var body: some View {
        
        VStack {
            
            XDismissButton(isShowingModal: $isShowingLoginView)
            
            VStack(spacing: 20) {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            .padding()
            
            Button {
                Task { await checkCanLogIn() }
            } label: {
                Label("Login", systemImage: "rectangle.portrait.and.arrow.forward")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .controlSize(.large)
            
            Spacer()
            
            Text("\(errorMessage)")
        }
    }
    
    func checkCanLogIn() async {
        var usernameResult = await checkIfUsernameExists(username: self.username)
        
        if !usernameResult {
            self.errorMessage = "User does not exist"
            return
        }
        
        var passwordResult = await checkPassword(username: self.username, inputPassword: self.password)
        
        if !passwordResult {
            errorMessage = "Incorrect password"
        } else {
            isShowingLoginView = false
            isLoggedIn = true
        }
    }
}

