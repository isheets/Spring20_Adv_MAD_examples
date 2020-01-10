//
//  FifthViewController.swift
//  music
//
//  Created by Isaac Sheets on 1/6/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit
import AVFoundation

class FifthViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    //instance variables
    let audioSession = AVAudioSession.sharedInstance()
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    //audio recording filename constant
    let filename = "audio.m4a"
    
    //button outlets
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    //button actions
    @IBAction func recordAudio(_ sender: Any) {
        //make sure we have an instance
        if let recorder = audioRecorder {
            //check to make sure we aren't already recording
            if recorder.isRecording == false {
                //enable the stop button and start recording
                playButton.isEnabled = false
                stopButton.isEnabled = true
                recorder.delegate = self //allows recorder to respond to errors and complete the recording
                recorder.record()
            }
        } else {
            print("No audio recorder instance")
        }
    }

    //either stop the recording or stop the playing, depending on which is currently happening
    @IBAction func stopAudio(_ sender: Any) {
        stopButton.isEnabled = false
        playButton.isEnabled = true
        recordButton.isEnabled = true
        
        //stop recording if that's the current task
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else { // stop the playback and reset the audio session mode
            audioPlayer?.stop()
            //reset session mode
            do {
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    @IBAction func playAudio(_ sender: Any) {
        //make sure we aren't recording
        if audioRecorder?.isRecording == false {
            stopButton.isEnabled = true
            recordButton.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: (audioRecorder?.url)!)
                //set to playback mode for optimal volume
                try audioSession.setCategory(AVAudioSession.Category.playback)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay() // preload audio
                audioPlayer!.play() //plays audio file
            } catch {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    
    //audio player delegate method to change buttons when audio finishes playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        //reset av session mode to optimize recording
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // enable play and stop since we don't have any audio to work with on load
        playButton.isEnabled = false
        stopButton.isEnabled = false
        
        //get path for the audio file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        let audioFileURL = docDir.appendingPathComponent(filename)
        print(audioFileURL)
        
        
        
        //configure our audioSession
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .init(rawValue: 1))
        } catch {
            print("audio session error: \(error.localizedDescription)")
        }
        
        //declare our settings in a dictionary
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC), // audio codec
            AVSampleRateKey: 1200, //sample rate in hZ
            AVNumberOfChannelsKey: 1, //num of channels
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue // audio bit rate
        ]
        
        do  {
            //create our recorder instance
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            //get it ready for recording by creating the audio file at the specified location
            audioRecorder?.prepareToRecord()
            print("Audio recorder ready!")
        } catch {
            print("Audio recorder error: \(error.localizedDescription)")
        }
    }
    

}
