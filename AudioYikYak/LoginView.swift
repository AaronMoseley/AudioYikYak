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
                isShowingLoginView = false
                isLoggedIn = true
            } label: {
                Label("Login", systemImage: "rectangle.portrait.and.arrow.forward")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .controlSize(.large)
            
            Spacer()
        }
    }
}

