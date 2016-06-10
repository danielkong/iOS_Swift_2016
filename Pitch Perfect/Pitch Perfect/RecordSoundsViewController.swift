//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Daniel Kong on 6/7/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        stopRecordingButton.enabled = false
//        var audioRecorder:AVAudioRecorder!
//        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
//        let recordingName = "recordedVoice.wav"
//        let pathArray = [dirPath, recordingName]
//        let filePath = NSURL.fileURLWithPathComponents(pathArray)
//        print(filePath)
//        
//        let session = AVAudioSession.sharedInstance()
//        try!
//            session.setCategory(AVAudioSessionCategoryPlayAndRecord)
//        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
//        audioRecorder.delegate = self
//        audioRecorder.meteringEnabled = true
//        audioRecorder.prepareToRecord()
//        audioRecorder.record()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopRecording(sender: AnyObject) {
        label.text = "Tap to record"
        startRecordingButton.enabled = true
        stopRecordingButton.enabled = false
        audioRecorder.stop()
    }
    @IBAction func recordAudio(sender: AnyObject) {
        label.text = "recording in progress..."
        startRecordingButton.enabled = false
        stopRecordingButton.enabled = true
        
        print("ping me")
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    
}

