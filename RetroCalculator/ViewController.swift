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
    
    @IBOutlet weak var outputLbl: UILabel!

    var bambooSound: AVAudioPlayer!

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Substract = "-"
        case Empty = "Empty"
    }

    var currentOperation = Operation.Empty

    var runningNumber = ""

    var lefValStr = ""

    var righValStr = ""

    var result = ""


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
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubstractPressed(sender: AnyObject) {
        processOperation(operation: .Substract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func clearLabel(sender: AnyObject) {
        clearOperation()
    }

    func playSound() {
        if bambooSound.isPlaying {
            bambooSound.stop()
        }
        
        bambooSound.play()
    }
    
    func clearOperation() {
        processOperation(operation: .Empty)
        runningNumber = ""
        outputLbl.text = "0"
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
            righValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Int(lefValStr)! * Int(righValStr)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Int(lefValStr)! / Int(righValStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Int(lefValStr)! + Int(righValStr)!)"
            } else if currentOperation == Operation.Substract {
                result = "\(Int(lefValStr)! - Int(righValStr)!)"
            }
            
            lefValStr = result
            outputLbl.text = result
        }
        currentOperation = operation
        } else {
            // This is the first time an operator has been pressed
            lefValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

