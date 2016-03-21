//
//  ViewController.swift
//  retro-calc
//
//  Created by Ryan Alexander Mansker on 3/20/16.
//  Copyright © 2016 Ryan Alexander Mansker. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: Types
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "empty"
        
    }
    
    //MARK: Properties
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    var currentOp: Operation = Operation.Empty
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    //MARK: Actions
    
    @IBAction func numberPress(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onPlusPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOp)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOp != Operation.Empty {
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOp == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOp == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOp == Operation.Subtract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            } else if currentOp == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputLbl.text = result
            
            currentOp = op
        } else {
            //This is the first time an Op has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOp = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}


























