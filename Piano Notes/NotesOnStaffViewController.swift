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
    
    
    @IBOutlet weak var pianoNoteDisplayed: UIImageView!
    
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
    
    // REFACTOR SOME (MOST?) OF THIS TO viewDidAppear() ?!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pianoNoteDisplayed.alpha = 1
        
        currentAccidental = .neither
        updateNoteOnStaffImage(optionalImageName: nil)
        
        generateNewNote()
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
    
//    var randomNewNoteIndex = 10
//    var lastRandomNumber = 10
    
    func generateNewNote() {
        
        // enable or disable buttons/keys depending on current game mode
//        switch currentGameMode {
//        case .A:
//            enableButtons()
//            enableSharps()
//            enableFlats()
//            disableWhiteKeyButtons()
//            disableBlackKeyButtons()
//        case .B:
//            disableButtons()
//            disableSharps()
//            disableFlats()
//            enableWhiteKeyButtons()
//            enableBlackKeyButtons()
//        }
        
        // remove notes marked wrong
//        if !notesAlreadyAttempted.isEmpty {
//            for subview in self.pianoKeyImage.subviews {
//                subview.removeFromSuperview()
//            }
//        }
        
//        notesAlreadyAttempted = [""]
        
//        if currentGameMode == .A {

        currentNoteChoices = whiteNotesOnLargeKeyboard
        setRandomNewNoteUpperIndex()
        generateNewRandomNoteIndex()
        print("currentNoteChoices[randomNewNoteIndex]: \(currentNoteChoices[randomNewNoteIndex])")
        lastRandomNumber = randomNewNoteIndex
        
        pianoNoteDisplayed.image = UIImage(named: "large_\(currentNoteChoices[randomNewNoteIndex])_shown")
        
        
//
//            currentNote = currentNoteChoices[randomNewNoteIndex]
//            print("the current note is \(currentNote)")
//
//            let currentNoteNameLength = currentNote.count
//
//            // 3-character note names need to be converted to 2-character ones
//            // (because octave doesn't matter)
//            if currentNoteNameLength == 3 {
//                currentCorrectAnswer = String(currentNote[currentNote.startIndex...currentNote.index(after: currentNote.startIndex)])
//                //            print("currentCorrectAnswer when name length == 3: \(currentCorrectAnswer)")
//            } else {
//                currentCorrectAnswer = String(currentNote[currentNote.startIndex])
//                //            print("currentCorrectAnswer when name length == \(currentNoteNameLength): \(currentCorrectAnswer)")
//            }
//            //        currentCorrectAnswer = String(currentNote[currentNote.startIndex])
//            print("currentCorrectAnswer is \(currentCorrectAnswer)")
//
//            pianoKeyImage.image = UIImage(named: "\(currentNote)_shown")
//
//            // MODE B
//        } else {
//
//            pianoKeyImage.image = nil
//
//            var upperNoteChoiceLimit = 6
//
//            // LIMIT NUMBER OF NOTE CHOICES FOR NEW NOTE
//
//            switch currentNoteChoices {
//            case onlyCDE:
//                upperNoteChoiceLimit = 2
//            case onlyFGAB, onlyWeirdEnharmonics:
//                upperNoteChoiceLimit = 3
//            default: break
//            }
//
//            randomNewNoteIndex = Int.random(in: 0...upperNoteChoiceLimit)
//
//            while randomNewNoteIndex == lastRandomNumber {
//                randomNewNoteIndex = Int.random(in: 0...upperNoteChoiceLimit)
//            }
//
//            var accidentalOrNot: Accidentals = .neither
//
//            if allNoteChoicesEnabled {
//
//                accidentalOrNotIndex = Int.random(in: 0...2)
//
//                while accidentalOrNotIndex == lastAccidentalOrNotIndex {
//                    accidentalOrNotIndex = Int.random(in: 0...2)
//                }
//
//                accidentalOrNot = Accidentals.allCases[accidentalOrNotIndex]
//
//            } else if onlyBlackKeysEnabled {
//
//                accidentalOrNotIndex = Int.random(in: 0...1)
//
//                //                while accidentalOrNotIndex == lastAccidentalOrNotIndex {
//                //                    accidentalOrNotIndex = Int.random(in: 0...1)
//                //                }
//
//                accidentalOrNot = Accidentals.allCases[accidentalOrNotIndex]
//
//            } else if onlyWeirdEnharmonicsEnabled {
//
//                accidentalOrNotIndex = Int.random(in: 0...1)
//
//                // IF I LEFT THIS IN, IT WOULD JUST KEEP SWITCHING, RIGHT?
//                //                while accidentalOrNotIndex == lastAccidentalOrNotIndex {
//                //                    accidentalOrNotIndex = Int.random(in: 1...2)
//                //                }
//
//                accidentalOrNot = Accidentals.allCases[accidentalOrNotIndex]
//
//            } else if onlySharpsEnabled {
//
//                accidentalOrNot = .sharp
//
//            } else if onlyFlatsEnabled {
//
//                accidentalOrNot = .flat
//
//            }
//
//            // if noteChoices[1] == "#" (for only sharps) !
//
//            switch accidentalOrNot {
//            case .neither:
//                // NOT BASIC NOTE NAMES, BUT... ?
//                switch currentNoteChoices {
//                case onlyCDE:
//                    currentNote = basicNoteNamesOnlyCDE[randomNewNoteIndex]
//                case onlyFGAB:
//                    currentNote = basicNoteNamesOnlyFGAB[randomNewNoteIndex]
//                default:
//                    currentNote = basicNoteNames[randomNewNoteIndex]
//                }
//
//                currentAccidental = .neither
//            case .sharp:
//                currentNote = basicNoteNames[randomNewNoteIndex] + "#"
//
//                // generate new note if current note is a weird enharmonic
//                if !weirdEnharmonicsEnabled && (currentNote == "B#" || currentNote == "E#") {
//                    generateNewNote()
//                } else {
//                    sharpsOutletCollection[randomNewNoteIndex].setImage(UIImage(named: "sharp_shown"), for: UIControl.State.normal)
//                    currentAccidental = .sharp
//                }
//            case .flat:
//                currentNote = basicNoteNames[randomNewNoteIndex] + "b"
//
//                // generate new note if current note is a weird enharmonic
//                if !weirdEnharmonicsEnabled && (currentNote == "Cb" || currentNote == "Fb") {
//                    generateNewNote()
//                } else {
//                    flatsOutletCollection[randomNewNoteIndex].setImage(UIImage(named: "flat_shown"), for: UIControl.State.normal)
//                    currentAccidental = .flat
//                }
//            }
//
//
//            print("current note should be: \(currentNote)")
//
//            currentCorrectAnswer = currentNote
//
//            let currentNoteToShow = currentNote[currentNote.startIndex]
//            let currentNoteIndex = basicNoteNames.firstIndex(of: String(currentNoteToShow))!
//
//            let buttonImageName = "\(currentNoteToShow)_shown"
//            guard let image = UIImage(named: buttonImageName) else { return }
//            noteButtonsOutletCollection![currentNoteIndex].setImage(image, for: UIControl.State.normal)
//
//        }
//
//        lastRandomNumber = randomNewNoteIndex
//        lastAccidentalOrNotIndex = accidentalOrNotIndex
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
