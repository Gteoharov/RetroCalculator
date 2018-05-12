//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Georgi Teoharov on 7.05.18.
//  Copyright © 2018 Georgi Teoharov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var bambooSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "Bamboo", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try bambooSound = AVAudioPlayer(contentsOf: soundURL)
            bambooSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        playSound()
    }
    
    func playSound() {
        if bambooSound.isPlaying {
            bambooSound.stop()
        }
        
        bambooSound.play()
    }
}

