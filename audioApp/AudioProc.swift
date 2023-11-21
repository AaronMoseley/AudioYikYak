//
//  AudioProc.swift
//  audioApp
//
//  Created by Sam Hite on 11/16/23.
//

import SwiftUI
import AVFoundation

struct AudioRecordView : View {
    @State var record = false
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    
    var body: some View {
        NavigationView{
            VStack {
                Button(action: {
                    do {
                        if self.record{
                            self.recorder.stop()
                            self.record.toggle()
                            return
                        }
                        self.recorder = createAudioRecorder()
                        self.recorder.record()
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
                NavigationLink(destination: AudioPlayView()){
                    Text("Click here to Play and edit Recording")
                }
            }
            .navigationBarTitle("Record and Play Audio")
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
    func createAudioRecorder() -> AVAudioRecorder? {
        let settings: [String: Any] = [
            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey : 12000,
            AVNumberOfChannelsKey : 2,
            AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
        ]
        let path = Bundle.main.path(forResource: "audio.m4a", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            let audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder.prepareToRecord()
            return audioRecorder
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    func createAudioPlayer() -> AVAudioPlayer? {
        let path = Bundle.main.path(forResource: "audio.m4a", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let audioFile = try AVAudioPlayer(contentsOf: url, fileTypeHint: "m4a")
            return audioFile
        }
        catch {
            print("Audio File Not Found")
            return nil
        }
    }
}
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
