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
    
    override func viewWillAppear(animated: Bool) {
        stopRecordingButton.enabled = false
    }
    
    private func setupRecordButtonEnable(enable: Bool) {
        label.text = enable ? "recording in progress..." : "Tap to record"
        startRecordingButton.enabled = !enable
        stopRecordingButton.enabled = enable
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

    @IBAction func stopRecording(sender: AnyObject) {
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        setupRecordButtonEnable(false)
        audioRecorder.stop()
    }
    
    @IBAction func recordAudio(sender: AnyObject) {
        setupRecordButtonEnable(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
//        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finished recording!")
        if flag == true {
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print("failed to save record")
        }
    }
}

//  https://discussions.udacity.com/t/playback-sound-too-soft-in-physical-device-it-is-loud-enough-in-simulator-though/41701

//you can also set the shared audio session (`AVAudioSession.sharedInstance()`)'s category to playback only while playing, and the audio session will choose which place to play the audio out of
