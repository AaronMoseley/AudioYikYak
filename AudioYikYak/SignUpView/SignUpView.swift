//
//  SignUpView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var isShowingSignUpView: Bool
    @State var user: User
    @State var username: String = ""
    @State var password: String = ""
    @StateObject var viewModel: SignUpViewModel
    @Binding var isLoggedIn: Bool
    @State var startView: StartView
    
    var body: some View {
        VStack {
            XDismissButton(isShowingModal: $isShowingSignUpView)
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
            Spacer()
            
            Text("\(viewModel.errorMessage)")
        }.background(UIValues.customBackground)
            .onChange(of: viewModel.shouldShowSignUpView) { oldValue, newValue in
                isShowingSignUpView = newValue
            }.onChange(of: viewModel.isLoggedIn) { oldValue, newValue in
                isLoggedIn = newValue
            }
            .environment(\.colorScheme, .light)
        
    }
    
    func signUp () async {
        if await viewModel.signUp(username: self.username, password: self.password) {
            var newUser = User(username: self.username, password: self.password, bio: "Add a bio about yourself!")
            self.user = newUser
            self.startView.currUser = self.user
        }
    }
}
