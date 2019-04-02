//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by William Ortiz on 3/27/19.
//  Copyright © 2019 wo984c. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!

    // MARK: IBOutlets

    // Changes the label's text when record button pressed
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Disables the Stop Button
        stopRecordingButton.isEnabled = false
        
        self.navigationItem.title = "Rec"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // Records audio when record button has been pressed
    @IBAction func recordAudio(_ sender: Any) {

        setUI(state: true)
        
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
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()

        // Records Audio
        audioRecorder.record()
    }

    // Stops Recording
    @IBAction func stopRecording(_ sender: Any) {

        setUI(state: false)
        audioRecorder.stop()

        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    // Calls the stopRecording segue and sends the audio url
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {

        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("failed to ecord audio")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL

            // Sets the audio URL in the PlaySoundsViewController
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

    // Enables and disables the record and stop buttons, and changes the label text
    func setUI(state: Bool) {

        if state {
            recordingLabel.text = "Recording in Process"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        } else {
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = "Tap tp Record"
        }
    }
}
