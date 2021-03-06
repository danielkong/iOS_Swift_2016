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
    
    @IBOutlet weak var overviewStackView: UIStackView!
    @IBOutlet weak var innerStackView1: UIStackView!
    @IBOutlet weak var innerStackView2: UIStackView!
    @IBOutlet weak var innerStackView3: UIStackView!
    @IBOutlet weak var stopPlayStackView: UIStackView!
    
    enum ButtonType: Int {
        case Chipmunk = 0,
        Vader,
        Echo,
        Reverb,
        Slow,
        Fast
    }
    
    @IBAction func playSounds(sender: UIButton) {
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
        stopAudio()
    }
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.NotPlaying)
        setStackViewLayout()

    }
    
    private func setStackViewLayout() {
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        
        if orientation.isPortrait{
            overviewStackView.axis = .Vertical
            setInnerStackViewsAxis(.Horizontal)
        } else {
            overviewStackView.axis = .Horizontal
            setInnerStackViewsAxis(.Vertical)
        }
    }
    
    func setInnerStackViewsAxis(axisStyle: UILayoutConstraintAxis)  {
        innerStackView1.axis = axisStyle
        innerStackView2.axis = axisStyle
        innerStackView3.axis = axisStyle
        stopPlayStackView.axis = axisStyle
    }
    
    // override this function to make sure when rotated to landscape, the buttons are not squeezed
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (context) -> Void in
            self.setStackViewLayout()
        }, completion: nil)
    }
}
