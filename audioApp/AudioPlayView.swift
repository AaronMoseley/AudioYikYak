//
//  AudioPlayView.swift
//  audioApp
//
//  Created by  on 11/16/23.
//

import SwiftUI
import AVFoundation
/*
struct AudioPlayView: View {
    @State var audioFile : AVAudioPlayer?
    var body: some View {
        Button(action: {
            if let  audioPlayer = createAudioPlayer() {
                audioPlayer.play()
            }
        }) {
            HStack {
                Image(systemName: "play.fill")
                    .font(.title)
                Text("Play Recording")
                    .font(.title)
            }
            .padding()
            .foregroundColor(.black)
            .background(.green)
            .cornerRadius(80)
        }
    }
    func createAudioPlayer() -> AVAudioPlayer? {
        let path = Bundle.main.path(forResource: "audio.m4a", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioFile = try AVAudioPlayer(contentsOf: url, fileTypeHint: "m4a")
            return audioFile
        }
        catch {
            print("Audio File Not Found")
            return nil
        }
    }
}
*/
