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
    @State private var showList = false
    @Binding var user: User
    
    var body: some View {
        NavigationView {
            VStack {
                
                if (showList) {
                    withAnimation{
                        RecordingsList(audioRecorder: audioRecorder)
                    }
                }
                
                AudioRecordView(audioRecorder: audioRecorder)
            }.background(
                NavigationLink(destination: ProfileView(user: user), isActive: $showProfile) {
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
            }
            .navigationBarTitle("For you", displayMode: .large)
        }
        
    }
}

#Preview {
    ContentView(audioRecorder: AudioRecorder(), audioPlayer: AudioPlayer(), user: .constant(mockUser))
}
