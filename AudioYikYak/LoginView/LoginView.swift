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
    @StateObject var viewModel: LoginViewModel
    @Binding var isShowingLoginView: Bool
    @Binding var isLoggedIn: Bool
    
    
    var body: some View {
        VStack {
            XDismissButton(isShowingModal: $isShowingLoginView)
            Spacer()
            VStack(spacing: 20) {
                TextField("Username", text: $username)
                    .padding()
                    .background(.white)
                    .cornerRadius(UIValues.cornerRadius)
                    .padding(EdgeInsets(top: 0,
                                        leading: UIValues.sidePadding,
                                        bottom: 0,
                                        trailing: UIValues.sidePadding))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(.white)
                    .cornerRadius(UIValues.cornerRadius)
                    .padding(EdgeInsets(top: 0,
                                        leading: UIValues.sidePadding,
                                        bottom: 0,
                                        trailing: UIValues.sidePadding))
                
            }
            .padding()
            
            Button {
                Task { await viewModel.checkCanLogIn(username: username, password: password) }
            } label: {
                Label("Login", systemImage: "rectangle.portrait.and.arrow.forward")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .controlSize(.large)
            
            Spacer()
            Spacer()
            
            Text("\(viewModel.errorMessage)")
        }
        .background(UIValues.customBackground)
        .onChange(of: viewModel.shouldShowLoginView) { oldValue, newValue in
            isShowingLoginView = newValue
        }
        .onChange(of: viewModel.isLoggedIn) { oldValue, newValue in
            isLoggedIn = newValue
        }
        .environment(\.colorScheme, .light)

    }
    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView(username: .constant(""), password: .constant(""), viewModel: .init(), isShowingLoginView: .constant(true), isLoggedIn: .constant(true))
        }
    }
}

