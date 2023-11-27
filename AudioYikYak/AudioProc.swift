//
//  AudioProc.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/27/23.
//

import SwiftUI
import AVFoundation

struct AudioRecordView : View {
    @ObservedObject var audioRecorder: AudioRecorder

    @State var record = false
    @State var alert = false
    
    var body: some View {
        VStack {
            Button(action: {
                do {
                    if self.record{
                        audioRecorder.stopRecording()
                        self.record.toggle()
                        return
                    }
                    audioRecorder.startRecording(username: "Seun")
                    self.record.toggle()
                }
            }){
                ZStack{
                    Circle()
                        .fill(Color.red)
                        .frame(width: 70, height: 70)
                    if self.record{
                        Circle()
                            .stroke(Color.black, lineWidth: 10)
                            .frame(width: 85, height: 85)
                    }
                }
            }
            .padding(.vertical, 25)
        }
        .alert(isPresented: self.$alert, content: {
            Alert(title: Text("Error"), message: Text("Enable Access"))
        })
    }
}

struct AudioPlayView: View {
    @ObservedObject var audioPlayer: AudioPlayer
    
    var body: some View {
        Button(action: {
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioFilename = documentPath.appendingPathComponent("Seun" + "-" + String(NSDate().timeIntervalSince1970) + ".m4a")
            audioPlayer.startPlayback(audio: audioFilename)
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
}
