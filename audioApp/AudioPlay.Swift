//
//  AudioProc.swift
//  audioApp
//
//  Created by Sam Hite on 11/16/23.
//

import SwiftUI
import AVFoundation

struct AudioPlayView : View {
    @State var record = false
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    @State var audios : [URL] = []
    @State var audioFile : AVAudioPlayer?
    
    var body: some View {
        NavigationView{
            VStack {
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
                Button(action: {
                    //AudioRecordView()
                }) {
                    HStack {
                        Text("Return to Recording")
                    }
                    
                }
            }
            .navigationBarTitle("Play Recorded Audio")
        }
        .alert(isPresented: self.$alert, content: {
            Alert(title: Text("Error"), message: Text("Enable Access"))
        })
        .onAppear {
            do {
                setupAudioSession()
            }
        }
    }
    func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            audioSession.requestRecordPermission { (status) in
                if !status {
                    self.alert.toggle()
                }
            }
        } catch {
            print(error.localizedDescription)
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

