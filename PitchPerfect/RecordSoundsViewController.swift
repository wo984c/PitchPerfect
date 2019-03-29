//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by William Ortiz on 3/27/19.
//  Copyright © 2019 wo984c. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder!
    
    // Changes the label's text when record button was pressed
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }

    // Records audio when record button has been pressed
    @IBAction func recordAudio(_ sender: Any) {
    
        recordingLabel.text = "Recording in Process"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        
        // Sets the path for the Audio file
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        // Creates the session to Play or Record Audio
        let session = AVAudioSession.sharedInstance()
       
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        // Prepares to Record
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        
        // Records Audio
        audioRecorder.record()
        
        
    }
    
    // Stop the Recording
    @IBAction func stopRecording(_ sender: Any) {
        
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap tp Record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
}
