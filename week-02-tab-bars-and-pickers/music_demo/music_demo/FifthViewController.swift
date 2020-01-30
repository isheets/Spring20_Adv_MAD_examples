//
//  FifthViewController.swift
//  music_demo
//
//  Created by Isaac Sheets on 1/28/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit
import AVFoundation

class FifthViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    //variables
    let audioSession = AVAudioSession.sharedInstance()
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    //constant
    let filename = "audio.m4a"
    
    //connections
    @IBOutlet weak var recordAudio: UIButton!
    @IBOutlet weak var playAudio: UIButton!
    @IBOutlet weak var stopAudio: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docDir = dirPath[0]
        let audioFilePath = docDir.appendingPathComponent(filename)
        print(audioFilePath)
        
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .init(rawValue: 1))
        } catch {
            print(error)
        }
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC), //audio codec
            AVSampleRateKey: 1200, //sample rate hZ
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue //bit rate
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilePath, settings: settings)
            audioRecorder?.prepareToRecord()
            print("Audio recorder ready!")
        } catch {
            print(error)
        }
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        
        if let recorder = audioRecorder {
            //we have an instance of AudioRecorder
            if recorder.isRecording == false {
                    
                playAudio.isEnabled = false
                stopAudio.isEnabled = true
                recorder.delegate = self
                
                recorder.record()
            }
            
        } else {
            print("no recorder!")
        }
        
    }
    
    @IBAction func playAudio(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            stopAudio.isEnabled = true
            recordAudio.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: (audioRecorder?.url)!)
                try audioSession.setCategory(AVAudioSession.Category.playback)
                
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            } catch {
                print("could not play audio")
            }
        }
    
    }
    
    //stop recording or playing based on what's happening
    @IBAction func stopAudio(_ sender: Any) {
        stopAudio.isEnabled = false
        playAudio.isEnabled = true
        recordAudio.isEnabled = true
        
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
            //reset session mode
            do {
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            } catch {
                print(error)
            }
        }
    }
    
    //delegate method for audioPlayer
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordAudio.isEnabled = true
        stopAudio.isEnabled = false
        
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
        } catch {
            print(error)
        }
    }
    
}
