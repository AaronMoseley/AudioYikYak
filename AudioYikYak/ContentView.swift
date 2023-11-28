//
//  ContentView.swift
//  AudioYikYak
//
//  Created by Aaron Moseley on 11/9/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var audioPlayer: AudioPlayer
    @State private var showProfile = false
    
    var body: some View {
        NavigationView {
            VStack {
                RecordingsList(audioRecorder: audioRecorder)
                AudioRecordView(audioRecorder: audioRecorder)
            }.background(
                NavigationLink(destination: ProfileView(user: .constant(mockUser)), isActive: $showProfile) {
                    EmptyView()
                }
            )
            .toolbar {
                ToolbarItem {
                    Button {
                        showProfile = true
                    } label: {
                        Text("Profile")
                    }
                }
            }
            .navigationBarTitle("For you", displayMode: .large)
        }
        
    }
}

#Preview {
    ContentView(audioRecorder: AudioRecorder(), audioPlayer: AudioPlayer())
}
