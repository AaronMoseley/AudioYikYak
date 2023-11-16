//
//  SignUpView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var isShowingSignUpView: Bool
    @Binding var username: String
    @Binding var password: String
    @ObservedObject var viewModel: SignUpViewModel
    @Binding var isLoggedIn: Bool

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
                    Task { await viewModel.signUp(username: username, password: password) }
                } label: {
                    Label("Sign Up", systemImage: "arrow.forward")
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .controlSize(.large)
            }
            .padding()
            
            Spacer()
            
            Text("\(viewModel.errorMessage)")
        }.onChange(of: viewModel.shouldShowSignUpView) { oldValue, newValue in
            isShowingSignUpView = newValue
        }.onChange(of: viewModel.isLoggedIn) { oldValue, newValue in
            isLoggedIn = newValue
        }
    }
    
    
}
