//
//  ViewController.swift
//  PitchPerfect
//
//  Created by William Ortiz on 3/27/19.
//  Copyright © 2019 wo984c. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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

    // Record audio when record button has been pressed
    @IBAction func recordAudio(_ sender: Any) {
    
        recordingLabel.text = "Recording in Process"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
    }
    
    // Stop the Recording
    @IBAction func stopRecording(_ sender: Any) {
        
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap tp Record"
        
    }
}

