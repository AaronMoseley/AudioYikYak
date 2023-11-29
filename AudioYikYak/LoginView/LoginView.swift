//
//  LoginView.swift
//  AudioYikYak
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var user: User
    @StateObject var viewModel: LoginViewModel
    @State var username: String = ""
    @State var password: String = ""
    @Binding var isShowingLoginView: Bool
    @Binding var isLoggedIn: Bool
    var startView: StartView
    
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
                Task { await login() }
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
    
    func login() async {
        let userInfo = await viewModel.checkCanLogIn(username: self.username, password: self.password)
        
        if !userInfo.isEmpty {
            let newUser = User(username: self.username, password: self.password, bio: userInfo[2])
            self.user = newUser
            self.startView.currUser = self.user
            print("updated user")
        }
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView(user: mockUser, viewModel: .init(), isShowingLoginView: .constant(true), isLoggedIn: .constant(true), startView: StartView(currUser: mockUser))
        }
    }
}

