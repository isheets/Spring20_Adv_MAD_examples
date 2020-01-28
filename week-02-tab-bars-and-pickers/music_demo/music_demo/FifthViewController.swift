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
    
    
    }
    
    @IBAction func playAudio(_ sender: Any) {
    
    
    }
    
    @IBAction func stopAudio(_ sender: Any) {
    
    
    }
    
}
