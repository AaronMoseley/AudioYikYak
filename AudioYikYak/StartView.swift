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
                SLButton(title: "Login", imageName: "rectangle.portrait.and.arrow.forward", isShowingModal: $isShowingLoginView)
                
                SLButton(title: "Sign Up", imageName: "arrow.forward", isShowingModal: $isShowingSignUpView)
            }
            
            .sheet(isPresented: $isShowingLoginView) {
                LoginView(isShowingLoginView: $isShowingLoginView, isLoggedIn: $isLoggedIn, username: $username, password: $password)
            }
            .sheet(isPresented: $isShowingSignUpView) {
                SignUpView(isShowingSignUpView: $isShowingSignUpView, isLoggedIn: $isLoggedIn, username: $username, password: $password)
            }
        }
    }
}

#Preview {
    StartView()
}

