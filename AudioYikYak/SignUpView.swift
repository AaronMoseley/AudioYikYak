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
                    isShowingSignUpView = false
                    isLoggedIn = true
                } label: {
                    Label("Sign Up", systemImage: "arrow.forward")
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .controlSize(.large)
            }
            .padding()
            
            Spacer()
        }
    }
}