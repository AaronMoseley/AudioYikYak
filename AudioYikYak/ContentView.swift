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

    var body: some View {
        VStack {
            RecordingsList(audioRecorder: audioRecorder)
            AudioRecordView(audioRecorder: audioRecorder)
        }.environment(\.colorScheme, .light)
    }
}

#Preview {
    //ContentView()
    ContentView(audioRecorder: AudioRecorder(), audioPlayer: AudioPlayer())
}
