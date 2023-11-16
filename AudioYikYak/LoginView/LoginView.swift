//
//  LoginView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var username: String
    @Binding var password: String
    @ObservedObject var viewModel: LoginViewModel
    @Binding var isShowingLoginView: Bool
    
    
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
                Task { await viewModel.checkCanLogIn(username: username, password: password, isShowingLoginView: isShowingLoginView) }
            } label: {
                Label("Login", systemImage: "rectangle.portrait.and.arrow.forward")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .controlSize(.large)
            
            Spacer()
            
            Text("\(viewModel.errorMessage)")
        }
        .onChange(of: viewModel.shouldShowLoginView) { newValue in
                    isShowingLoginView = newValue
                }
    }
    
}
