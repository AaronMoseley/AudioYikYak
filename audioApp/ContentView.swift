//
//  ContentView.swift
//  audioApp
//
//  Created by  on 11/16/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//
//  ContentView.swift
//  testAudioApp
//
//  Created by Sam Hite on 11/7/23.
//

import SwiftUI
import AVFoundation


struct ContentView : View {
    @State var record = false
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false

    
    var body: some View {
        NavigationView{
            HStack {
                Button(action: {
                    do {
                        if self.record{
                            self.recorder.stop()
                            self.record.toggle()
                            return
                        }
                        if let audioRecorder = createAudioRecorder() {
                            audioRecorder.record()
                        }
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
            .navigationBarTitle("Record Audio")
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
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) [0]
        let fileName = url.appendingPathComponent("testRec.m4a")
        do {
            let audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            return audioRecorder
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    func createAudioPlayer() -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: "audio", withExtension: "m4a")
        else {
            print("Error: Audio file not found")
            return nil
        }
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            return audioPlayer
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
