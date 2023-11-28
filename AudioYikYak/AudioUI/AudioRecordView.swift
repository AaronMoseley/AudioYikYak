//
//  AudioRecordView.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/28/23.
//

import Foundation
import SwiftUI
import AVFoundation
import DSWaveformImage
import DSWaveformImageViews

struct AudioRecordView: View {
    @StateObject var audioRecorder: AudioRecorder
    
    @State private var isRecording = false
    @State private var liveConfiguration: Waveform.Configuration = Waveform.Configuration(
        style: .striped(.init(color: .white, width: 3, spacing: 3))
    )
    
    
    @State private var showAlert = false
    @State private var audioSamples: [Float] = []
    var body: some View {
        ZStack(){
            WaveformLiveCanvas(
                samples: audioSamples,
                configuration: liveConfiguration,
                shouldDrawSilencePadding: true
            ).padding(0)
                .frame(height: 100)
                .onReceive(audioRecorder.$samples) { samples in
                    audioSamples = samples
                }
                .opacity(0.5)
            
            VStack {
                RecordingButton(isRecording: $isRecording) {
                    if isRecording {
                        audioRecorder.stopRecording()
                    } else {
                        audioRecorder.startRecording(username: "Seun")
                    }
                    isRecording.toggle()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Please enable microphone access in settings."))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue)
    }
    
}

struct RecordingButton: View {
    @Binding var isRecording: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(isRecording ? Color.red : Color.gray)
                    .frame(width: 70, height: 70)
                if isRecording {
                    Circle()
                        .stroke(Color.black, lineWidth: 5)
                        .frame(width: 65, height: 65)
                }
            }
        }
    }
}

#Preview {
    AudioRecordView(audioRecorder: .init())
}
