//
//  AudioPlayView.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/28/23.
//

import Foundation
import SwiftUI
import AVFoundation

struct AudioPlayView: View {
    var audioURL: URL
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        VStack {
            HStack {
                Text(audioURL.lastPathComponent)
                Spacer()
                PlayStopButton(isPlaying: audioPlayer.isPlaying, action: {
                    audioPlayer.isPlaying ? audioPlayer.stopPlayback() : audioPlayer.startPlayback(audio: audioURL)
                })
            }
        }
        .padding()
    }
}

struct PlayStopButton: View {
    let isPlaying: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isPlaying ? "stop.fill" : "play.circle")
                .imageScale(.large)
        }
    }
}
