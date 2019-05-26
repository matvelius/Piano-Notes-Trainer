//
//  NotesOnStaffViewController.swift
//  Piano Notes
//
//  Created by Matvey on 5/15/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class NotesOnStaffViewController: UIViewController {
    
    @IBOutlet weak var noteOnStaffImage: UIImageView!
    
    var currentNoteOnStaffImageName = ""
    
    @IBOutlet var panGestureRecognizerOutlet: UIPanGestureRecognizer!
    
    
    @IBAction func sharpButtonPressed(_ sender: UIButton) {
        
        
        let currentNoteOnStaffImageNameSecondToLastCharacter = currentNoteOnStaffImageName[currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -2)]
        
        print("currentNoteOnStaffImageName: \(currentNoteOnStaffImageName), currentNoteOnStaffImageNameSecondToLastCharacter: \(currentNoteOnStaffImageNameSecondToLastCharacter)")
        
        if  currentAccidental == .neither {
            
            currentAccidental = .sharp
            
            currentNoteOnStaffImageName.insert("#", at: currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -1))
            
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
            
        } else if currentAccidental == .flat {
            
            currentAccidental = .sharp
            
            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "b", with: "#")
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
        }
        
//        if  currentNoteOnStaffImageNameSecondToLastCharacter != "#" && currentNoteOnStaffImageNameSecondToLastCharacter != "b" {
//            currentNoteOnStaffImageName.insert("#", at: currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -1))
//            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
//        } else if currentNoteOnStaffImageNameSecondToLastCharacter == "b" {
//            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "b", with: "#")
//            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
//        }
    }
    
    @IBAction func naturalButtonPressed(_ sender: UIButton) {
        
        let currentNoteOnStaffImageNameSecondToLastCharacter = currentNoteOnStaffImageName[currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -2)]
        
        print("currentNoteOnStaffImageName: \(currentNoteOnStaffImageName), currentNoteOnStaffImageNameSecondToLastCharacter: \(currentNoteOnStaffImageNameSecondToLastCharacter)")
        
        if currentAccidental == .sharp {
            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "#", with: "")
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
            currentAccidental = .neither
        } else if currentAccidental == .flat {
            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "b", with: "")
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
            currentAccidental = .neither
        }
        
//        if currentNoteOnStaffImageNameSecondToLastCharacter == "#" {
//            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "#", with: "")
//            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
//        } else if currentNoteOnStaffImageNameSecondToLastCharacter == "b" {
//            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "b", with: "")
//            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
//        }
    }
    
    @IBAction func flatButtonPressed(_ sender: UIButton) {
        
        let currentNoteOnStaffImageNameSecondToLastCharacter = currentNoteOnStaffImageName[currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -2)]
        
        print("currentNoteOnStaffImageName: \(currentNoteOnStaffImageName), currentNoteOnStaffImageNameSecondToLastCharacter: \(currentNoteOnStaffImageNameSecondToLastCharacter)")
        
        if  currentAccidental == .neither {
            
            currentAccidental = .flat
            
            currentNoteOnStaffImageName.insert("b", at: currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -1))
            
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
            
        } else if currentAccidental == .sharp {
            
            currentAccidental = .flat
            
            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "#", with: "b")
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
        }
        
//        if  currentNoteOnStaffImageNameSecondToLastCharacter != "#" && currentNoteOnStaffImageNameSecondToLastCharacter != "b" {
//            currentNoteOnStaffImageName.insert("b", at: currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -1))
//            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
//        } else if currentNoteOnStaffImageNameSecondToLastCharacter == "#" {
//            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "#", with: "b")
//            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
//        }
    }
    
    @IBAction func upArrowButtonPressed(_ sender: UIButton) {
        if currentNoteIndex < whiteNotesOnLargeKeyboard.count - 1 {
            currentNoteIndex += 1
            updateNoteOnStaffImage(optionalImageName: nil)
            currentAccidental = .neither
        }
    }
    
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    var userAnswer = ""
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        userAnswer = currentNoteOnStaffImageName
        print(userAnswer)
        checkAnswer()
        
        // generate new note; be sure to reset the accidental!
    }
    
    @IBAction func downArrowButtonPressed(_ sender: UIButton) {
        if currentNoteIndex > 0 {
            currentNoteIndex -= 1
            updateNoteOnStaffImage(optionalImageName: nil)
            currentAccidental = .neither
        }
    }
    

    var currentNoteIndex = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentAccidental = .neither
        updateNoteOnStaffImage(optionalImageName: nil)
        
    }
    
    var locationTracker: Double = Double(whiteNotesOnLargeKeyboard.count / 2) {
        didSet {
            currentNoteIndex = Int(round(locationTracker))
            updateNoteOnStaffImage(optionalImageName: nil)
            currentAccidental = .neither
        }
    }
    
    func updateNoteOnStaffImage(optionalImageName: String?) {
        if let imageName = optionalImageName {
            noteOnStaffImage.image = UIImage(named: imageName)
        } else {
            currentNoteOnStaffImageName = "staff\(whiteNotesOnLargeKeyboard[currentNoteIndex])"
            noteOnStaffImage.image = UIImage(named: currentNoteOnStaffImageName)
        }
        print("currentNoteOnStaffImageName: \(currentNoteOnStaffImageName)")
        print("locationTracker: \(locationTracker)")
        print("currentNoteIndex: \(currentNoteIndex)")

    }
    
    func checkAnswer() {
        print("check answer")
    }
    
    @IBAction func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
//        print(recognizer.velocity(in: self.view).y)
        
        if recognizer.velocity(in: self.view).y < 0 && Int(locationTracker) < whiteNotesOnLargeKeyboard.count - 1 {
//            print("panning up!")
            locationTracker += 0.17
            
            if recognizer.velocity(in: self.view).y < -150 && Int(locationTracker) < whiteNotesOnLargeKeyboard.count - 1 {
                locationTracker += 0.5
            }
        
        } else if recognizer.velocity(in: self.view).y > 0 && locationTracker > 0 {
            locationTracker -= 0.17
//            print("panning down!")
            
            if recognizer.velocity(in: self.view).y > 150 && locationTracker > 0 {
                locationTracker -= 0.5
            }
        }
        
    }
    
}
