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
    

    var body: some View {
        if (isLoggedIn) {
            ContentView(audioRecorder: AudioRecorder(), audioPlayer: AudioPlayer(), isLoggedIn: $isLoggedIn)
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
            SignUpView(isLoggedIn: $isLoggedIn)
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .center
        )
        .background(UIValues.customBackground)
        .onAppear {
          viewModel.connect(authenticationService: authenticationService)
        }
    }
    
    /*func testDownloadFile() async {
        let finished = { (input: Bool) in
            print(input)
        }

        let username = await downloadAudioFile(completion: finished, index: 0, outputFileName: "/Users/aaronmoseley/Desktop/AudioYikYak/testAudio.mp3")
        
        print(username)
    }
    
    func testUploadFile() async {
        await uploadAudioFile(username: "testUsername", currentFileName: "/Users/aaronmoseley/Desktop/AudioYikYak/testAudio.mp3")
    }*/
}

#Preview {
    StartView()
}

