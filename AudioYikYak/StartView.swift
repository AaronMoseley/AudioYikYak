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
    @State private var isLoggedIn: Bool = false
    @State public var currUser: User
    

    var body: some View {
        if (isLoggedIn) {
            ContentView(audioRecorder: AudioRecorder(), audioPlayer: AudioPlayer(), user: $currUser)
        }
        else {
            VStack(spacing: 40) {
                Spacer()
                Text("rekord").font(Font.system(size:40, design: .monospaced))
                SLButton(title: "  Login  ", imageName: "rectangle.portrait.and.arrow.forward", isShowingModal: $isShowingLoginView)
                
                SLButton(title: "Sign Up", imageName: "arrow.forward", isShowingModal: $isShowingSignUpView)
                Spacer()
            }
            .sheet(isPresented: $isShowingLoginView) {
                LoginView(user: currUser, viewModel: .init(), isShowingLoginView: $isShowingLoginView, isLoggedIn: $isLoggedIn, startView: self)
            }
            .sheet(isPresented: $isShowingSignUpView) {
                SignUpView(isShowingSignUpView: $isShowingSignUpView, user: currUser, viewModel: .init(), isLoggedIn: $isLoggedIn, startView: self)
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
    StartView(currUser: mockUser)
}

