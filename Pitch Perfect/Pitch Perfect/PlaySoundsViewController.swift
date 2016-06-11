//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Daniel Kong on 6/10/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    enum ButtonType: Int {
        case Chipmunk = 0,
        Vader,
        Echo,
        Reverb,
        Slow,
        Fast
    }
    
    @IBAction func playSounds(sender: UIButton) {
        print("play")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        }
        configureUI(.Playing)
        
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        print("stop")
        stopAudio()
    }
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view Did Load")
        setupAudio()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
