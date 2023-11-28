//
//  AudioPlayView.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/28/23.
//

import Foundation
import SwiftUI
import AVFoundation
import DSWaveformImage
import DSWaveformImageViews

struct AudioPlayView: View {
    var audioURL: URL
    @ObservedObject var audioPlayer = AudioPlayer()
    @State var progress: Float = 0.0
    
    var body: some View {
        VStack {
            HStack {
                if doesFileExist(at: audioURL) {
                    ProgressWaveformView(audioURL: audioURL, progress: $progress)
                    Spacer()
                    PlayStopButton(isPlaying: audioPlayer.isPlaying, action: {
                        audioPlayer.isPlaying ? audioPlayer.stopPlayback() : audioPlayer.startPlayback(audio: audioURL)
                    })
                }
                
            }.onReceive(audioPlayer.$progress){ newProgress in
                progress = newProgress
                print("Progress - \(progress)")
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
struct ProgressWaveformView: View {
    let audioURL: URL
    @Binding var progress: Float
    
    var body: some View {
        GeometryReader { geometry in
            if (geometry.size.width != 0) {
                withAnimation {
                    WaveformView(audioURL: audioURL) { shape in
                        shape.fill(.white)
                        shape.fill(.red).mask(alignment: .leading) {
                            Rectangle().frame(width: geometry.size.width * CGFloat(progress))
                        }
                    }
                }
            }
        }
    }
}
