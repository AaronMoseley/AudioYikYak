//
//  SignUpView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI
import FirebaseAuth


struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel()
    @EnvironmentObject var authenticationService: AuthenticationService
    @Environment(\.dismiss) var dismiss
    
    @Binding var isLoggedIn: Bool
    @Binding var currUser: CustomUser
    @Binding var isShowingSignUp: Bool
    
    @FocusState private var focus: FocusableField?
    
    private func createUser() {
        Task {
            if await viewModel.createUser() == true {
                if let user = Auth.auth().currentUser {
                    currUser = await CustomUser(username: getUsername(user: user), bio: getBio(user: user))
                }
                dismiss()
                isLoggedIn = true
            }
        }
    }
    
    var body: some View {
        VStack {
            XDismissButton(isShowingModal: $isShowingSignUp)
            Spacer()
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image(systemName: "person")
                TextField("Username", text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($focus, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        self.focus = .email
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 4)
            
            HStack {
                Image(systemName: "at")
                TextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($focus, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        self.focus = .password
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 4)
            
            HStack {
                Image(systemName: "lock")
                SecureField("Password", text: $viewModel.password)
                    .focused($focus, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        createUser()
                    }
            }
            .padding(.vertical, 6)
            .background(Divider(), alignment: .bottom)
            .padding(.bottom, 8)
            
            if !viewModel.errorMessage.isEmpty {
                VStack {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color(UIColor.systemRed))
                }
            }
            
            Button(action: createUser) {
                if viewModel.authenticationState != .authenticating {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                }
                else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                }
            }
            .disabled(!viewModel.isValid)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            Spacer()
        }
        .onAppear {
            viewModel.connect(authenticationService: authenticationService)
        }
        .listStyle(.plain)
        .padding()
    }
}

