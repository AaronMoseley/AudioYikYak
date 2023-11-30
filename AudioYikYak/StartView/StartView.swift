//
//  StartView.swift
//  rekord
//
//  Created by Benjamin Woosley on 11/9/23.
//

import SwiftUI
import FirebaseAuth

struct StartView: View {
    
    @StateObject var viewModel = StartViewModel()
    @EnvironmentObject var authenticationService: AuthenticationService
    
    @State private var isShowingLoginView = false
    @State private var isShowingSignUpView = false
    @State private var isLoggedIn: Bool = false
    @State private var currUser: CustomUser = CustomUser(username: "", bio: "")
    
    var body: some View {
        if (isLoggedIn) {
            ContentView(audioRecorder: AudioRecorder(), audioPlayer: AudioPlayer(), isLoggedIn: $isLoggedIn, currUser: $currUser)
        }
        else {
            content
        }
    }
    
    var content: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("rekord").font(Font.system(size:40, design: .monospaced))
            SLButton(title: "  Login  ", imageName: "rectangle.portrait.and.arrow.forward", isShowingModal: $isShowingLoginView)
            
            SLButton(title: "Sign Up", imageName: "arrow.forward", isShowingModal: $isShowingSignUpView)
            Spacer()
        }
        .sheet(isPresented: $isShowingLoginView) {
            LoginView(isLoggedIn: $isLoggedIn)
        }
        .sheet(isPresented: $isShowingSignUpView) {
            SignUpView(isLoggedIn: $isLoggedIn, currUser: $currUser)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        )
        .background(UIValues.customBackground)
        .task {
            print("getting the current user")
            viewModel.connect(authenticationService: authenticationService)
            if let currentUser = Auth.auth().currentUser {
                currUser = await viewModel.getCurrUser(user: currentUser)
                isLoggedIn = true
            }
        }
    }
}

