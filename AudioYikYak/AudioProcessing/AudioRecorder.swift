//
//  AudioRecorder.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/27/23.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    @Published var samples: [Float] = []
    private var audioRecorder: AVAudioRecorder!
    private var recordingSession: AVAudioSession!
    private let sampleLimit = 1000
    private var timer: Timer?
    private var currFileName: URL = URL(fileURLWithPath: "")
    
    override init() {
        super.init()
        setupRecordingSession()
        fetchRecording()
    }
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var recordings = [Recording]()
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    private func setupRecordingSession() {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            // Handle error in setting up recording session
            print("Recording session setup failed: \(error)")
        }
    }
    
    func startRecording(username: String) {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent(username + "-" + String(NSDate().timeIntervalSince1970) + ".m4a")
        currFileName = audioFilename
        
        let settings: [String: Any] = [
            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey : 12000,
            AVNumberOfChannelsKey : 2,
            AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.isMeteringEnabled = true
            audioRecorder.record()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateRecordingProgress), userInfo: nil, repeats: true)
            recording = true
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording(username: String) {
        audioRecorder.stop()
        timer?.invalidate()
        recording = false
        fetchRecording()
        samples.removeAll()
        
        Task { await uploadAudioFile(username: username, currentFileName: currFileName) }
        currFileName = URL(fileURLWithPath: "")
    }
    
    @objc func updateRecordingProgress() {
        audioRecorder.updateMeters()
        let linear = 1 - pow(10, audioRecorder.averagePower(forChannel: 0) / 20)
        DispatchQueue.main.async {
            if self.samples.count >= self.sampleLimit {
                self.samples.removeFirst()
            }
            self.samples += [linear, linear, linear, linear, linear, linear, linear, linear, linear]
        }
    }
    
    func fetchRecording() {
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getFileDate(for: audio))
            recordings.append(recording)
        }
        
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
        objectWillChange.send(self)
    }
    
    func deleteRecording(urlsToDelete: [URL]) {
        for url in urlsToDelete {
            print(url)
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print("File could not be deleted!")
            }
        }
        
        fetchRecording()
    }
}
