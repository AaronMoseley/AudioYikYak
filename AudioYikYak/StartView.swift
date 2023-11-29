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
            ContentView(newUser: $currUser)
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
            .task {
                delete()
                await downloadFiles()
            }
        }
    }
    
    func downloadFiles() async {
        let numFiles = await getNumberOfAudioFiles()
        if numFiles <= 0 {
            return
        }
        
        let finished = { (input: Bool) in
            if input {
                print("File downloaded successfully")
                
            } else {
                print("File not downloaded")
            }
        }
        
        var index = 0
        let currentTimeStamp = NSDate().timeIntervalSince1970
        var fileName = await getAudioFileName(index: index)
        let timeLimit: Double = 100000
        var fileTimeStamp = getTimeStamp(fileName: fileName)
        
        while currentTimeStamp - fileTimeStamp <= timeLimit && fileTimeStamp > 0  && index < numFiles {
            await downloadAudioFile(completion: finished, index: index, outputDirectory: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
            
            index += 1
            
            if index >= numFiles {
                break
            }
            
            fileName = await getAudioFileName(index: index)
            fileTimeStamp = getTimeStamp(fileName: fileName)
        }
    }
    
    func getTimeStamp(fileName: String) -> Double {
        var stringStamp = fileName.components(separatedBy: "-")[1]
        stringStamp = stringStamp.components(separatedBy: ".")[0]
        return Double(stringStamp) ?? -1
    }
    
    func delete() {
        do {
            for audioFile in try FileManager.default.contentsOfDirectory(atPath: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].absoluteString) {
                do {
                    try FileManager.default.removeItem(at: URL(fileURLWithPath: audioFile))
                } catch {
                    print("File could not be deleted!")
                }
            }
        } catch {
            return
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

