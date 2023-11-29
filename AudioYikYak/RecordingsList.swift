//
//  RecordingsList.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/27/23.
//

import Foundation
import SwiftUI

struct RecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        ScrollView {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL).padding(EdgeInsets(top: 5, leading: 17.5, bottom: 20, trailing: 17.5))
            }
        }
         .task {
            //delete()
            //await downloadFiles()
            //audioRecorder.fetchRecording()
        }
    }
}

struct RecordingRow: View {
    var audioURL: URL
    @ObservedObject var audioPlayer = AudioPlayer()
    
    
    var body: some View {
        VStack {
            Text(audioURL.lastPathComponent.components(separatedBy: "-")[0]).font(Font.custom("Inter", size: 11))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .trailing)
            AudioPlayView(audioURL: audioURL).background(Color(red: 0.93, green: 0.93, blue: 0.93))
                .cornerRadius(7.5)
        }
    }
}

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingsList(audioRecorder: AudioRecorder())
    }
}
