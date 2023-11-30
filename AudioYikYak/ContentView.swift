//
//  ContentView.swift
//  AudioYikYak
//
//  Created by Aaron Moseley on 11/9/23.
//

import SwiftUI
import SwiftData
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var audioPlayer: AudioPlayer
    @State private var showProfile = false
    @State private var showList = false
    @Binding var isLoggedIn: Bool
    @Binding var currUser: CustomUser
    
    var body: some View {
        NavigationView {
            VStack {
                
                if (showList) {
                    withAnimation{
                        RecordingsList(audioRecorder: audioRecorder)
                    }
                }
                
                AudioRecordView(audioRecorder: audioRecorder, currUser: $currUser)
            }
            .background(
                NavigationLink(destination: ProfileView(currUser: $currUser), isActive: $showProfile) {
                    EmptyView()
                }
            )
            .onAppear {
                showList = true
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showProfile = true
                    }) {
                        Image(systemName: "person.crop.circle")
                    }
                }
                ToolbarItem {
                    Button(action: {
                        try! Auth.auth().signOut()
                        print("signed out")
                        isLoggedIn = false
                    }) {
                        Text("Sign Out")
                    }
                }
            }
            .navigationBarTitle("For you", displayMode: .large)
        }
        .task {
            self.audioRecorder.fetchRecording()
        }
    }
    
}

