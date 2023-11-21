//
//  StartView.swift
//  rekord
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI

struct StartView: View {
    
    @State private var isShowingLoginView = false
    @State private var isShowingSignUpView = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    

    var body: some View {
        if (isLoggedIn) {
            ContentView()
        }
        else {
            VStack(spacing: 40) {
                Spacer()
                SLButton(title: "Login", imageName: "rectangle.portrait.and.arrow.forward", isShowingModal: $isShowingLoginView)
                
                SLButton(title: "Sign Up", imageName: "arrow.forward", isShowingModal: $isShowingSignUpView)
                Spacer()
            }
            .sheet(isPresented: $isShowingLoginView) {
                LoginView(username: $username, password: $password, viewModel: .init(), isShowingLoginView: $isShowingLoginView, isLoggedIn: $isLoggedIn)
            }
            .sheet(isPresented: $isShowingSignUpView) {
                SignUpView(isShowingSignUpView: $isShowingSignUpView, username: $username, password: $password, viewModel: .init(), isLoggedIn: $isLoggedIn)
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .center
                )
            .background(UIValues.customBackground)
        }
    }
}

#Preview {
    StartView()
}
