//
//  ViewController.swift
//  Piano Notes
//
//  Created by Matvey on 1/29/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit
import AVFoundation

// audio toolbox has lower latency?
//import AudioToolbox


class ViewController: UIViewController {
    
    // instance variable to hold the AVAudioPlayer object
    var audioPlayer: AVAudioPlayer?
    
    // placeholder variables for comparing answers
    var currentCorrectAnswer = ""
    var currentUserAnswer = ""
    
    // placeholder for current note
    var currentNote = ""
    
    var menuIsClosed: Bool = true
    
    
    @IBOutlet weak var menuButtonOutlet: UIButton!
    
    @IBOutlet weak var darkOverlayOutlet: UIButton!
    
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    
    // close menu
    @IBAction func darkOverlayPressed(_ sender: UIButton) {
        
        self.menuLeadingConstraint.constant = -460
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            
            self.view.layoutIfNeeded()
            self.darkOverlayOutlet.alpha = 0
            self.menuBackgroundOutlet.alpha = 0
            
        })
        
        menuButtonOutlet.setTitle("☰", for: .normal)
        
        menuIsClosed = true
        
    }
    
    @IBOutlet weak var menuBackgroundOutlet: UIView!
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        
        // figure out how to slide the menu out
        
        if menuIsClosed {
            
            self.menuLeadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                
                self.view.layoutIfNeeded()
                self.menuButtonOutlet.alpha = 0
                self.darkOverlayOutlet.alpha = 0.73
                self.menuBackgroundOutlet.alpha = 1
                
            })
        
            self.menuButtonOutlet.setTitle("✕", for: .normal)
            
            UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseIn, animations: {
                self.menuButtonOutlet.alpha = 1
                self.view.layoutIfNeeded()
            })
            
            menuIsClosed = false
            
        } else {
            
            self.menuLeadingConstraint.constant = -460
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            
                self.view.layoutIfNeeded()
                self.menuButtonOutlet.alpha = 0
                self.darkOverlayOutlet.alpha = 0
                self.menuBackgroundOutlet.alpha = 0
            
            })
            
            self.menuButtonOutlet.setTitle("☰", for: .normal)
            
            UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseIn, animations: {
                self.menuButtonOutlet.alpha = 1
                self.view.layoutIfNeeded()
            })
            
            menuIsClosed = true
            
        }
        
    }
    
    
    @IBAction func modeSwitchFlipped(_ sender: UISegmentedControl) {
//        currentGameMode = (currentGameMode == .B) ? .A : .B
        
        switch currentGameMode {
        case .A:
            currentGameMode = .B
            includeEnharmonicsSwitchOutlet.isEnabled = true
        case .B:
            currentGameMode = .A
            includeEnharmonicsSwitchOutlet.isEnabled = false
        }
        
        startNewRound()
    }
    
    
    @IBOutlet weak var onlyWhiteKeysSwitchOutlet: UISwitch!
    
    @IBAction func onlyWhiteKeysSwitch(_ sender: UISwitch) {
        
        // disable sharps and flats, make them invisible, disable gesture recognizers
        if sender.isOn == true {
            
            setToOnlyWhiteKeys()
        
            disableSharps()
            sharpsViewOutlet.alpha = 0
            disableFlats()
            flatsViewOutlet.alpha = 0
            
            disableGestureRecognizers()
            
            startNewRound()
        
        // otherwise reenable everything
        } else {
            
            setToAllNoteChoices()
            
            enableButtons()
            
            whiteKeySettingsSegmentedControlOutlet.selectedSegmentIndex = 0
            
            
            enableSharps()
            sharpsViewOutlet.alpha = 1
            enableFlats()
            flatsViewOutlet.alpha = 1
            
            enableGestureRecognizers()
            
            startNewRound()
            
        }
            
    }
    
    
    @IBOutlet weak var whiteKeySettingsSegmentedControlOutlet: UISegmentedControl!
    
    // enable / disable based on the white keys switch
    @IBAction func whiteKeySettingsSegmentedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            // all white keys
            setToOnlyWhiteKeys()
            
            onlyWhiteKeysSwitchOutlet.setOn(true, animated: true)
            
            enableButtons()
            
            noteButtonA.alpha = 1
            noteButtonB.alpha = 1
            noteButtonC.alpha = 1
            noteButtonD.alpha = 1
            noteButtonE.alpha = 1
            noteButtonF.alpha = 1
            noteButtonG.alpha = 1
            
            startNewRound()
            
        } else if sender.selectedSegmentIndex == 1 {
            
            // only C D E
            setToOnlyCDE()
            
            onlyWhiteKeysSwitchOutlet.setOn(true, animated: true)
            
            disableButtons()
            disableSharps()
            sharpsViewOutlet.alpha = 0
            disableFlats()
            flatsViewOutlet.alpha = 0
            
            noteButtonA.alpha = 0.3
            noteButtonB.alpha = 0.3
            noteButtonF.alpha = 0.3
            noteButtonG.alpha = 0.3
            
            noteButtonC.alpha = 1
            noteButtonD.alpha = 1
            noteButtonE.alpha = 1
            
            noteButtonC.isEnabled = true
            noteButtonD.isEnabled = true
            noteButtonE.isEnabled = true
            
            startNewRound()
            
        } else {
            
            // only F G A B
            setToOnlyFGAB()
            
            onlyWhiteKeysSwitchOutlet.setOn(true, animated: true)

            disableButtons()
            disableSharps()
            sharpsViewOutlet.alpha = 0
            disableFlats()
            flatsViewOutlet.alpha = 0
            
            noteButtonC.alpha = 0.3
            noteButtonD.alpha = 0.3
            noteButtonE.alpha = 0.3
            
            noteButtonA.alpha = 1
            noteButtonB.alpha = 1
            noteButtonF.alpha = 1
            noteButtonG.alpha = 1
            
            noteButtonF.isEnabled = true
            noteButtonG.isEnabled = true
            noteButtonA.isEnabled = true
            noteButtonB.isEnabled = true
            
            startNewRound()
            
        }
        
    }
    
    
    @IBOutlet weak var includeEnharmonicsSwitchOutlet: UISwitch!
    
    // mode B only!
    @IBAction func includeEnharmonicsSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            weirdEnharmonicsEnabled = true
        } else {
            weirdEnharmonicsEnabled = false
        }
        
    }
    
    @IBAction func onlyBlackKeysSwitch(_ sender: UISwitch) {
        if sender.isOn {
            setToOnlyBlackKeys()
            weirdEnharmonicsEnabled = false
            onlyWhiteKeysSwitchOutlet.setOn(false, animated: true)
            startNewRound()
        } else {
            setToAllNoteChoices()
            startNewRound()
        }
    }

    @IBOutlet weak var blackKeySettingsSegmentedControlOutlet: UISegmentedControl!
    
    @IBAction func blackKeySettingsSegmentedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // all black keys
            setToOnlyBlackKeys()
            
            enableSharps()
            sharpsViewOutlet.alpha = 1
            enableFlats()
            flatsViewOutlet.alpha = 1
            
        } else if sender.selectedSegmentIndex == 1 {
            // only sharps
            setToOnlySharps()
            
            enableSharps()
            sharpsViewOutlet.alpha = 1
            disableFlats()
            flatsViewOutlet.alpha = 0
            
        } else {
            // only flats
            setToOnlyFlats()
            
            disableSharps()
            sharpsViewOutlet.alpha = 0
            enableFlats()
            flatsViewOutlet.alpha = 1
        }
        
        startNewRound()
        
    }
    
    var soundsEnabled = true
    
    @IBAction func enableSoundsSwitch(_ sender: UISwitch) {
        if sender.isOn {
            soundsEnabled = false
        } else {
            soundsEnabled = true
        }
    }
    
    @IBAction func reEnableExplainersSwitch(_ sender: UISwitch) {
    }
    
    @IBOutlet var panGestureRecognizersCollection: [UIPanGestureRecognizer]!
    
    
    // note button outlets
    @IBOutlet weak var noteButtonA: UIButton!
    @IBOutlet weak var noteButtonB: UIButton!
    @IBOutlet weak var noteButtonC: UIButton!
    @IBOutlet weak var noteButtonD: UIButton!
    @IBOutlet weak var noteButtonE: UIButton!
    @IBOutlet weak var noteButtonF: UIButton!
    @IBOutlet weak var noteButtonG: UIButton!
    
    
    @IBOutlet var noteButtonsOutletCollection: [UIButton]!
    
    @IBOutlet var sharpsOutletCollection: [UIButton]!
    
    // placeholders for calculating sharps & flats bounds
    // to use for pan gesture recognition
    
    @IBOutlet weak var sharpsViewOutlet: UIView!
    
    @IBOutlet weak var flatsViewOutlet: UIView!
    
    var sharpsLowerBound: CGFloat = 0.0
    var sharpsUpperBound: CGFloat = 0.0
    var flatsLowerBound: CGFloat = 0.0
    var flatsUpperBound: CGFloat = 0.0
    var noteButtonLowerBoundY: CGFloat = 0.0
    var noteButtonUpperBoundY: CGFloat = 0.0
    var noteButtonLowerBoundX: CGFloat = 0.0
    var noteButtonUpperBoundX: CGFloat = 0.0
    
    @IBOutlet var flatsOutletCollection: [UIButton]!
    
    
    // placeholder variable for the button user presses
    var currentNoteButton: UIButton!
    
    
    @IBOutlet weak var pianoBackgroundImage: UIImageView!
    
    // piano image outlet
    @IBOutlet weak var pianoKeyImage: UIImageView!
    
    // placeholder variable for keeping the score
    var totalScore = 0
    @IBOutlet weak var scoreLabel: UILabel!
    
    // placeholder variable for keeping track of stars
    @IBOutlet weak var stars: UIImageView!
    // current number of stars
    var currentNumberOfStars = 0
    // keeping track of correct answers in a row to give stars
    var correctAnswersInARow = 0
    // keeping track of incorrect answers in a row to take away stars
    var incorrectAnswersInARow = 0
    
    
    // placeholder variable for last-selected random number
    var lastRandomNumber: Int = -1
    var randomNewNoteIndex = Int.random(in: 0...15)
    var lastAccidentalOrNotIndex: Int = -1
    var accidentalOrNotIndex = Int.random(in: 0...2)
    
    // SHOULD I ANIMATE THE BUTTON SIZE?
    @IBOutlet weak var noteButtonAHeight: NSLayoutConstraint!
    
    @IBOutlet var whiteKeyButtons: [UIButton]!
    
    @IBOutlet var blackKeyButtons: [UIButton]!
    
    var whiteKeyButtonIndex = 0
    var nameOfKeyToHighlight = ""
    
    
    @IBAction func whiteKeyButtonTouched(_ sender: UIButton) {
        print("white key touched; sender.tag: \(sender.tag)")
        
        whiteKeyButtonIndex = sender.tag
        
        nameOfKeyToHighlight = onlyWhiteKeys[whiteKeyButtonIndex - 1]
        
        pianoKeyImage.image = UIImage(named: "\(nameOfKeyToHighlight)_pressed")
    }
    
    
    @IBAction func touchDraggedOutsideKeyButton(_ sender: UIButton) {
        pianoKeyImage.image = nil
    }

    
    @IBAction func whiteKeyButtonPressed(_ sender: UIButton) {
        print("white key sender.tag: \(sender.tag)")
        
        whiteKeyButtonIndex = sender.tag
        nameOfKeyToHighlight = onlyWhiteKeys[whiteKeyButtonIndex - 1]
//        pianoKeyImage.image = UIImage(named: "\(nameOfKeyToHighlight)_pressed")
        currentUserAnswer = String(nameOfKeyToHighlight[nameOfKeyToHighlight.startIndex])
//        currentCorrectAnswer = String(currentNote[currentNote.startIndex...currentNote.index(after: currentNote.startIndex)])
        print("currentUserAnswer: \(currentUserAnswer)")
//        currentNoteButton = noteButtonB
//        setCurrentNoteXBounds()
        
        checkAnswer()
    }
    
    @IBAction func blackKeyButtonTouched(_ sender: UIButton) {
        
        guard let blackKeyButtonIndex = Int(sender.accessibilityIdentifier!) else { return }
        
        print("black key touched; blackKeyButtonIndex: \(blackKeyButtonIndex)")
        nameOfKeyToHighlight = onlyBlackKeys[blackKeyButtonIndex]
        pianoKeyImage.image = UIImage(named: "\(nameOfKeyToHighlight)_pressed")
        
    }
    
    
    @IBAction func blackKeyButtonPressed(_ sender: UIButton) {
        
        guard let blackKeyButtonIndex = Int(sender.accessibilityIdentifier!) else { return }
        nameOfKeyToHighlight = onlyBlackKeys[blackKeyButtonIndex]
        
        currentUserAnswer = String(nameOfKeyToHighlight[nameOfKeyToHighlight.startIndex...nameOfKeyToHighlight.index(after: nameOfKeyToHighlight.startIndex)])
        
        print("currentUserAnswer: \(currentUserAnswer)")
        
        checkAnswer()
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // sort sharps & flats outlet collections
        sharpsOutletCollection = sharpsOutletCollection.sorted(by: { $0.tag < $1.tag })
        flatsOutletCollection = flatsOutletCollection.sorted(by: { $0.tag < $1.tag })
        
        ////////////////////////////////////////////
        //////// LINE UP BLACK KEY BUTTONS /////////
        ////////////////////////////////////////////
        
        // sort the black keys outlet collection by tag
        // use sort by!
        blackKeyButtons = blackKeyButtons.sorted(by: { $0.tag < $1.tag })
        
        let angleIncrement = 0.024
        
        var positiveRotationTransforms = [CGAffineTransform]()
        var negativeRotationTransforms = [CGAffineTransform]()
        
        // calculate rotation transforms
        for angleMultiplier in (0...9) {
            positiveRotationTransforms.append(CGAffineTransform(rotationAngle: CGFloat(Double(angleMultiplier) * (angleIncrement))))
            negativeRotationTransforms.append(CGAffineTransform(rotationAngle: CGFloat(Double(angleMultiplier) * -(angleIncrement))))
        }
        
        let translation1xPositive = CGAffineTransform(translationX: 10, y: 0)
        let translation1xNegative = CGAffineTransform(translationX: -10, y: 0)
        let translation2xPositive = CGAffineTransform(translationX: 20, y: 0)
        let translation2xNegative = CGAffineTransform(translationX: -20, y: 0)
        
        // concat with translation transforms
        let blackKey1Transform = positiveRotationTransforms[8]
        let blackKey2Transform = positiveRotationTransforms[7].concatenating(translation1xPositive)
        let blackKey3Transform = positiveRotationTransforms[6].concatenating(translation2xPositive)
        let blackKey5Transform = positiveRotationTransforms[4]
        let blackKey6Transform = positiveRotationTransforms[3].concatenating(translation1xPositive)
        let blackKey8Transform = positiveRotationTransforms[1].concatenating(translation1xNegative)
        let blackKey10Transform = negativeRotationTransforms[1].concatenating(translation1xPositive)
        let blackKey12Transform = negativeRotationTransforms[3].concatenating(translation1xNegative)
        let blackKey13Transform = negativeRotationTransforms[4]
        let blackKey15Transform = negativeRotationTransforms[6].concatenating(translation2xNegative)
        let blackKey16Transform = negativeRotationTransforms[7].concatenating(translation1xNegative)
        let blackKey17Transform = negativeRotationTransforms[8]
        
        blackKeyButtons[0].isEnabled = false
        blackKeyButtons[0].alpha = 0
        blackKeyButtons[1].transform = blackKey1Transform
        blackKeyButtons[2].transform = blackKey2Transform
        blackKeyButtons[3].transform = blackKey3Transform
        blackKeyButtons[4].isEnabled = false
        blackKeyButtons[4].alpha = 0
        blackKeyButtons[5].transform = blackKey5Transform
        blackKeyButtons[6].transform = blackKey6Transform
        blackKeyButtons[7].isEnabled = false
        blackKeyButtons[7].alpha = 0
        blackKeyButtons[8].transform = blackKey8Transform
        blackKeyButtons[10].transform = blackKey10Transform
        blackKeyButtons[11].isEnabled = false
        blackKeyButtons[11].alpha = 0
        blackKeyButtons[12].transform = blackKey12Transform
        blackKeyButtons[13].transform = blackKey13Transform
        blackKeyButtons[14].isEnabled = false
        blackKeyButtons[14].alpha = 0
        blackKeyButtons[15].transform = blackKey15Transform
        blackKeyButtons[16].transform = blackKey16Transform
        blackKeyButtons[17].transform = blackKey17Transform
        blackKeyButtons[18].isEnabled = false
        blackKeyButtons[18].alpha = 0
        
        print("blackKeyButtons[1].accessibilityIdentifier: \(blackKeyButtons[1].accessibilityIdentifier)")
        
        ////////////////////////////////////////////
        //////// LINE UP WHITE KEY BUTTONS /////////
        ////////////////////////////////////////////
        
        // sort the black keys outlet collection by tag
        whiteKeyButtons = whiteKeyButtons.sorted(by: { $0.tag < $1.tag })
        
        // rotate and move white keys on the left
        for index in (0...7) {
            whiteKeyButtons[index].transform = positiveRotationTransforms[8 - index].concatenating(CGAffineTransform(translationX: CGFloat(Double((8-index)) * 1.2), y: 0)).concatenating(CGAffineTransform(scaleX: CGFloat(1 - (Double(7-index) * 0.008)), y: 1))
        }
        
        // rotate and move white keys on the right
        for index in (1...9) {
            whiteKeyButtons[index + 8].transform = negativeRotationTransforms[index].concatenating(CGAffineTransform(translationX: CGFloat(Double((index)) * -1.6), y: 0)).concatenating(CGAffineTransform(scaleX: CGFloat(1 - (Double(index) * 0.008)), y: 1))
//            whiteKeyButtons[index + 8].transform = negativeRotationTransforms[index]
        }
        
        whiteKeyButtons[0].isEnabled = false
        whiteKeyButtons[17].isEnabled = false
        
        // sort the note buttons outlet collection by tag
        noteButtonsOutletCollection = noteButtonsOutletCollection.sorted(by: { $0.tag < $1.tag })
        
        setupGameForCurrentLevel()
        
        calculateSharpAndFlatBounds()
        
        
        menuBackgroundOutlet.alpha = 0
        
        menuLeadingConstraint.constant = -460
        
        switch Level.currentLevel.id {
        case 4, 5, 6, 7:
            onlyWhiteKeysSwitchOutlet.setOn(false, animated: true)
        default:
            onlyWhiteKeysSwitchOutlet.setOn(true, animated: true)
        }
        // add this to levels above
        includeEnharmonicsSwitchOutlet.isEnabled = false
        weirdEnharmonicsEnabled = false
        
        blackKeySettingsSegmentedControlOutlet.isEnabled = true
        
        scoreLabel.text = "0"
        
        startNewRound()

    }
    
    func startNewRound() {
        
        lastRandomNumber = randomNewNoteIndex
        totalScore = 0
        scoreLabel.text = "0"
        correctAnswersInARow = 0
        incorrectAnswersInARow = 0
        currentNumberOfStars = 0
        stars.image = UIImage(named: "stars\(currentNumberOfStars)")
        resetButtonsToDefault()

        generateNewNote()
        
    }
    
    func generateNewNote() {
        
        switch currentGameMode {
        case .A:
            enableButtons()
            enableSharps()
            enableFlats()
            disableWhiteKeyButtons()
            disableBlackKeyButtons()
        case .B:
            disableButtons()
            disableSharps()
            disableFlats()
            enableWhiteKeyButtons()
            enableBlackKeyButtons()
        }
        
        if !notesAlreadyAttempted.isEmpty {
            for subview in self.pianoKeyImage.subviews {
                subview.removeFromSuperview()
            }
        }
        
        notesAlreadyAttempted = [""]
        
        if currentGameMode == .A {
        
            randomNewNoteIndex = Int.random(in: 0...randomNewNoteIndexUpperLimit)
            
            while randomNewNoteIndex == lastRandomNumber {
                randomNewNoteIndex = Int.random(in: 0...randomNewNoteIndexUpperLimit)
            }
            
            currentNote = currentNoteChoices[randomNewNoteIndex]
            print("the current note is \(currentNote)")
            
            let currentNoteNameLength = currentNote.count
            
            // 3-character note names need to be converted to 2-character ones
            // (because octave doesn't matter)
            if currentNoteNameLength == 3 {
                currentCorrectAnswer = String(currentNote[currentNote.startIndex...currentNote.index(after: currentNote.startIndex)])
    //            print("currentCorrectAnswer when name length == 3: \(currentCorrectAnswer)")
            } else {
                currentCorrectAnswer = String(currentNote[currentNote.startIndex])
    //            print("currentCorrectAnswer when name length == \(currentNoteNameLength): \(currentCorrectAnswer)")
            }
    //        currentCorrectAnswer = String(currentNote[currentNote.startIndex])
            print("currentCorrectAnswer is \(currentCorrectAnswer)")
            
            pianoKeyImage.image = UIImage(named: "\(currentNote)_shown")
           
        // MODE B
        } else {
            
            pianoKeyImage.image = nil
            
            var upperNoteChoiceLimit = 6
            
            // LIMIT NUMBER OF NOTE CHOICES FOR NEW NOTE
            
            switch currentNoteChoices {
            case onlyCDE:
                upperNoteChoiceLimit = 2
            case onlyFGAB, onlyWeirdEnharmonics:
                upperNoteChoiceLimit = 3
            default: break
            }
            
            randomNewNoteIndex = Int.random(in: 0...upperNoteChoiceLimit)
            
            while randomNewNoteIndex == lastRandomNumber {
                randomNewNoteIndex = Int.random(in: 0...upperNoteChoiceLimit)
            }
            
            var accidentalOrNot: Accidentals = .neither
            
            if allNoteChoicesEnabled || onlyBlackKeysEnabled {
            
                accidentalOrNotIndex = Int.random(in: 0...2)
                
                while accidentalOrNotIndex == lastAccidentalOrNotIndex {
                    accidentalOrNotIndex = Int.random(in: 0...2)
                }
                
                accidentalOrNot = Accidentals.allCases[accidentalOrNotIndex]
            
            } else if onlyWeirdEnharmonicsEnabled {
                
                accidentalOrNotIndex = Int.random(in: 1...2)
                
                // IF I LEFT THIS IN, IT WOULD JUST KEEP SWITCHING, RIGHT?
//                while accidentalOrNotIndex == lastAccidentalOrNotIndex {
//                    accidentalOrNotIndex = Int.random(in: 1...2)
//                }
                
                accidentalOrNot = Accidentals.allCases[accidentalOrNotIndex]
            
            } else if onlySharpsEnabled {
                
                accidentalOrNot = .sharp
                
            } else if onlyFlatsEnabled {
                
                accidentalOrNot = .flat
                
            }
            
            // if noteChoices[1] == "#" (for only sharps) !

            switch accidentalOrNot {
            case .neither:
                // NOT BASIC NOTE NAMES, BUT... ?
                switch currentNoteChoices {
                case onlyCDE:
                    currentNote = basicNoteNamesOnlyCDE[randomNewNoteIndex]
                case onlyFGAB:
                    currentNote = basicNoteNamesOnlyFGAB[randomNewNoteIndex]
                default:
                    currentNote = basicNoteNames[randomNewNoteIndex]
                }
                
                currentAccidental = .neither
            case .sharp:
                currentNote = basicNoteNames[randomNewNoteIndex] + "#"
            
                // generate new note if current note is a weird enharmonic
                if !weirdEnharmonicsEnabled && (currentNote == "B#" || currentNote == "E#") {
                    generateNewNote()
                } else {
                    sharpsOutletCollection[randomNewNoteIndex].setImage(UIImage(named: "sharp_shown"), for: UIControl.State.normal)
                    currentAccidental = .sharp
                }
            case .flat:
                currentNote = basicNoteNames[randomNewNoteIndex] + "b"
                
                // generate new note if current note is a weird enharmonic
                if !weirdEnharmonicsEnabled && (currentNote == "Cb" || currentNote == "Fb") {
                    generateNewNote()
                } else {
                    flatsOutletCollection[randomNewNoteIndex].setImage(UIImage(named: "flat_shown"), for: UIControl.State.normal)
                    currentAccidental = .flat
                }
            }
            
            
            print("current note should be: \(currentNote)")
            
            currentCorrectAnswer = currentNote
            
            let currentNoteToShow = currentNote[currentNote.startIndex]
            let currentNoteIndex = basicNoteNames.firstIndex(of: String(currentNoteToShow))!
           
            let buttonImageName = "\(currentNoteToShow)_shown"
            guard let image = UIImage(named: buttonImageName) else { return }
            noteButtonsOutletCollection![currentNoteIndex].setImage(image, for: UIControl.State.normal)
            
        }
        
        lastRandomNumber = randomNewNoteIndex
        lastAccidentalOrNotIndex = accidentalOrNotIndex
        
    }
    
    // for keeping track of piano keys already tried
    var notesAlreadyAttempted = [String]()
    
    func checkAnswer() {
        
        // placeholder variable for button image name
        var imageName = ""
        
        // get enharmonic equivalent
        let currentEnharmonic: String? = getEnharmonic(currentNote: currentUserAnswer)
        
        print("currentEnharmonic: \(currentEnharmonic)")
        
        // right answer
        if currentUserAnswer == currentCorrectAnswer || currentEnharmonic == currentCorrectAnswer {
            
            print("CORRECT")
            
            switch currentGameMode {
                
            case .A:
                // if dealing with sharp or flat, light up regular letter + #/b symbol
                if currentUserAnswer.count == 2 {
                    
                    switch currentAccidental {
                        
                    case .flat:
                        for flat in flatsOutletCollection {
                            if flat.tag == currentNoteButton.tag {
                                flat.setImage(UIImage(named: "flat_right"), for: .normal)
                            }
                        }
                    case .sharp:
                        for sharp in sharpsOutletCollection {
                            if sharp.tag == currentNoteButton.tag {
                                sharp.setImage(UIImage(named: "sharp_right"), for: .normal)
                            }
                        }
                    case .neither:
                        break
                    }
                    
                }
                
                // deal w/ enharmonics (user answers Cb, correct answer is B)
                if currentEnharmonic == currentCorrectAnswer {
                    
                    // change the correct note buttons' colors
                    imageName = "\(currentUserAnswer[currentUserAnswer.startIndex])_right"
                    
                } else {
                    
                    imageName = "\(currentCorrectAnswer[currentCorrectAnswer.startIndex])_right"
                    
                }
                
                print("imageName = \(imageName)")
                let image = UIImage(named: imageName)
                currentNoteButton.setImage(image, for: UIControl.State.normal)
                
                disableButtons()
                
            case .B:
                // turn the key user pressed to green
                // (identify whether it's a white or black key)
                print("CORRECT! CASE .B")
                
//                nameOfKeyToHighlight = onlyWhiteKeys[whiteKeyButtonIndex - 1]
                
                pianoKeyImage.image = UIImage(named: "\(nameOfKeyToHighlight)_right")
                
                disableWhiteKeyButtons()
                disableBlackKeyButtons()
                
            }
            
            // play sound
            if soundsEnabled {
                
                switch currentGameMode {
                case .A: loadSound(currentSound: currentNote)
                case .B: loadSound(currentSound: nameOfKeyToHighlight)
                }
                
                audioPlayer!.play()
                audioPlayer!.setVolume(0, fadeDuration: 2.5)
            }
            //            print(currentNote)
            //            play(sound: "\(currentNote)", ofType: .wav)
            
            
            // ANIMATING BUTTON SIZE ON CORRECT ANSWER:
//            noteButtonAHeight.constant = 130
//
//            UIView.animate(withDuration: 2.5) {
//                self.view.layoutIfNeeded()
//            }
            
//            self.menuLeadingConstraint.constant = -460
            
//            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
//
//                self.view.layoutIfNeeded()
//                self.darkOverlayOutlet.alpha = 0
//                self.menuBackgroundOutlet.alpha = 0
//
//            })
            
            // update score
            totalScore += 1
            correctAnswersInARow += 1
            incorrectAnswersInARow = 0
            giveOrTakeAStar()
            
            //            usleep(1000000) //will sleep for 1 second
            //            Thread.sleep(forTimeInterval: 60/cadence)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                
                self.resetButtonsToDefault()
                
                switch currentGameMode {
                case .A:
                    self.enableButtons()
                    print("buttons should be enabled!")
                case .B:
                    self.enableWhiteKeyButtons()
                    self.enableBlackKeyButtons()
                }
                
                self.generateNewNote()
            })
            
        // wrong answer
        } else {
            
            print("wrong!")
            
            // show result (red button)
            // if dealing with sharp or flat, light up regular letter + #/b symbol
            if currentUserAnswer.count == 2 && currentGameMode == .A {
                
                switch currentAccidental {
                    
                case .flat:
                    for flat in flatsOutletCollection {
                        if flat.tag == currentNoteButton.tag {
                            flat.setImage(UIImage(named: "flat_wrong"), for: .normal)
                        }
                    }
                case .sharp:
                    for sharp in sharpsOutletCollection {
                        if sharp.tag == currentNoteButton.tag {
                            sharp.setImage(UIImage(named: "sharp_wrong"), for: .normal)
                        }
                    }
                case .neither:
                    break
                }
                
            }
            
            // play "wrong" sound
            if soundsEnabled {
                loadSound(currentSound: "wrong")
                audioPlayer!.play()
                audioPlayer!.setVolume(0.05, fadeDuration: 0)
            }
            
            print("currentUserAnswer is: \(currentUserAnswer)")
            
            if currentGameMode == .A {
                // color button red
                imageName = "\(currentUserAnswer[currentUserAnswer.startIndex])_wrong"
                print("imageName is \(imageName)")
                let image = UIImage(named: imageName)
                currentNoteButton.setImage(image, for: UIControl.State.normal)
                
            // MODE B wrong answer
            } else {
                
                pianoKeyImage.image = nil
                
                if !notesAlreadyAttempted.contains(nameOfKeyToHighlight) {
                    
                    let wrongNoteImageName = "\(nameOfKeyToHighlight)_wrong"
                    let wrongNoteImage = UIImage(named: wrongNoteImageName)
                    let wrongNoteImageView = UIImageView(image: wrongNoteImage!)
                    
                    wrongNoteImageView.translatesAutoresizingMaskIntoConstraints = false
                    pianoKeyImage.addSubview(wrongNoteImageView)
                    
                    NSLayoutConstraint.activate([
                        wrongNoteImageView.widthAnchor.constraint(equalToConstant: pianoKeyImage!.frame.width),
                        wrongNoteImageView.heightAnchor.constraint(equalToConstant: pianoKeyImage!.frame.height),
        
                    ])
                    
                }
                
                notesAlreadyAttempted.append(nameOfKeyToHighlight)
                
            }
                
            // subtract a point
            if totalScore > 0 {
                totalScore -= 1
            }
            
            // flash score label red #FF3939
            self.scoreLabel.textColor = UIColor(red:1.00, green:0.22, blue:0.22, alpha:1.0)
            // bring it back to green after a second
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
                self.scoreLabel.textColor = UIColor(red:0.50, green:0.96, blue:0.00, alpha:1.0)
            })
            
            correctAnswersInARow = 0
            incorrectAnswersInARow += 1
            giveOrTakeAStar()
            
        }
        
        scoreLabel.text = String(totalScore)
    }
    
    // decide whether or not to give/take some stars
    func giveOrTakeAStar() {
        
        // add stars when user gets 5, 10, 15, 20, 25 correct answers in a row
        switch correctAnswersInARow {
        case 5:
            if currentNumberOfStars < 1 {
                currentNumberOfStars = 1
            }
        case 10:
            if currentNumberOfStars < 2 {
                currentNumberOfStars = 2
            }
        case 15:
            if currentNumberOfStars < 3 {
                currentNumberOfStars = 3
            }
        case 20:
            if currentNumberOfStars < 4 {
                currentNumberOfStars = 4
            }
        case 25:
            if currentNumberOfStars < 5 {
                currentNumberOfStars = 5
            }
        default:
            break
        }
        
        // take away a star each time user gets 3 answers in a row incorrectly
        if incorrectAnswersInARow == 3 {
            // only take away stars if the user actually has them
            if currentNumberOfStars > 0 {
                currentNumberOfStars -= 1
            }
            // reset number of incorrect answers in a row
            incorrectAnswersInARow = 0
        }
        
        stars.image = UIImage(named: "stars\(currentNumberOfStars)")
    }
    
    func resetButtonsToDefault() {
        
        var image = UIImage(named: "C_default")
        self.noteButtonC.setImage(image, for: UIControl.State.normal)

        image = UIImage(named: "D_default")
        self.noteButtonD.setImage(image, for: UIControl.State.normal)

        image = UIImage(named: "E_default")
        self.noteButtonE.setImage(image, for: UIControl.State.normal)

        image = UIImage(named: "F_default")
        self.noteButtonF.setImage(image, for: UIControl.State.normal)

        image = UIImage(named: "G_default")
        self.noteButtonG.setImage(image, for: UIControl.State.normal)

        image = UIImage(named: "A_default")
        self.noteButtonA.setImage(image, for: UIControl.State.normal)

        image = UIImage(named: "B_default")
        self.noteButtonB.setImage(image, for: UIControl.State.normal)
        
        for flat in flatsOutletCollection {
            image = UIImage(named: "flat")
            flat.setImage(image, for: UIControl.State.normal)
        }
        
        for sharp in sharpsOutletCollection {
            image = UIImage(named: "sharp")
            sharp.setImage(image, for: UIControl.State.normal)
        }

    }
    
    func disableButtons() {
        
        noteButtonA.isEnabled = false;
        noteButtonB.isEnabled = false;
        noteButtonC.isEnabled = false;
        noteButtonD.isEnabled = false;
        noteButtonE.isEnabled = false;
        noteButtonF.isEnabled = false;
        noteButtonG.isEnabled = false;
    }
    
    func enableButtons() {
        
        if onlyCDEEnabled {
            
            noteButtonC.isEnabled = true;
            noteButtonD.isEnabled = true;
            noteButtonE.isEnabled = true;
            
            noteButtonA.alpha = 0.3
            noteButtonB.alpha = 0.3
            noteButtonF.alpha = 0.3
            noteButtonG.alpha = 0.3
            
            noteButtonC.alpha = 1
            noteButtonD.alpha = 1
            noteButtonE.alpha = 1
            
        } else if onlyFGABEnabled {
            
            noteButtonF.isEnabled = true;
            noteButtonG.isEnabled = true;
            noteButtonA.isEnabled = true;
            noteButtonB.isEnabled = true;
            
            noteButtonA.alpha = 1
            noteButtonB.alpha = 1
            noteButtonF.alpha = 1
            noteButtonG.alpha = 1
            
            noteButtonC.alpha = 0.3
            noteButtonD.alpha = 0.3
            noteButtonE.alpha = 0.3
            
        } else {
                
            noteButtonA.isEnabled = true;
            noteButtonB.isEnabled = true;
            noteButtonC.isEnabled = true;
            noteButtonD.isEnabled = true;
            noteButtonE.isEnabled = true;
            noteButtonF.isEnabled = true;
            noteButtonG.isEnabled = true;
            
            noteButtonA.alpha = 1
            noteButtonB.alpha = 1
            noteButtonC.alpha = 1
            noteButtonD.alpha = 1
            noteButtonE.alpha = 1
            noteButtonF.alpha = 1
            noteButtonG.alpha = 1
            
        }
    }
    
    func loadSound(currentSound: String) {
        // sound file
        if let sound = Bundle.main.path(forResource: currentSound, ofType: "aiff") {

            do {
                // try to initialize with the URL created above
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                audioPlayer?.prepareToPlay()
            }
            catch {
                print(error)
            }
        } else {
            print("whoops, couldn't load the sound '\(currentSound)'")
        }
    }
    
    
    
    @IBAction func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        
        let currentYCoordinateOfPanInRespectToSharps = recognizer.location(in: sharpsOutletCollection.first).y
        
        let currentYCoordinateOfPanInRespectToFlats = recognizer.location(in: flatsOutletCollection.first).y
        
        let currentYCoordinateOfPanInRespectToNoteButtons = recognizer.location(in: currentNoteButton).y
        
        let currentXCoordinateOfPanInRespectToCurrentNoteButton = recognizer.location(in: currentNoteButton).x
        
        
        // determine if the user's finger is within the sharps range
        let recognizerWithinSharpRange = (sharpsLowerBound...sharpsUpperBound).contains(currentYCoordinateOfPanInRespectToSharps) && (noteButtonLowerBoundX...noteButtonUpperBoundX).contains(currentXCoordinateOfPanInRespectToCurrentNoteButton)
        
        // determine if the user's finger is within the flats range
        let recognizerWithinFlatRange = (flatsLowerBound...flatsUpperBound).contains(currentYCoordinateOfPanInRespectToFlats) && (noteButtonLowerBoundX...noteButtonUpperBoundX).contains(currentXCoordinateOfPanInRespectToCurrentNoteButton)
        
        let recognizerWithinNoteButtonRange = (noteButtonLowerBoundY...noteButtonUpperBoundY).contains(currentYCoordinateOfPanInRespectToNoteButtons) && (noteButtonLowerBoundX...noteButtonUpperBoundX).contains(currentXCoordinateOfPanInRespectToCurrentNoteButton)
        
        // alter the sharp & flat buttons depending on
        // where the user's finger is
        if recognizerWithinSharpRange {
            
            for sharp in sharpsOutletCollection {
                if sharp.tag == currentNoteButton.tag {
                    sharp.setImage(UIImage(named: "sharp_pressed"), for: .normal)
                }
            }
            
//            // THIS WORKS!!! do it everywhere -- UMM NO IT DOESN'T!
//            let currentSharp = sharpsOutletCollection[currentNoteButton.tag - 1]
//            currentSharp.setImage(UIImage(named: "sharp_pressed"), for: .normal)
            
        } else if recognizerWithinFlatRange {
            
//            let currentFlat = flatsOutletCollection[currentNoteButton.tag - 1]
//            currentFlat.setImage(UIImage(named: "flat_pressed"), for: .normal)
            
            for flat in flatsOutletCollection {
                if flat.tag == currentNoteButton.tag {
                    flat.setImage(UIImage(named: "flat_pressed"), for: .normal)
                }
            }
            
        } else {
            
//            let currentSharp = sharpsOutletCollection[currentNoteButton.tag - 1]
//            currentSharp.setImage(UIImage(named: "sharp"), for: .normal)
//
//            let currentFlat = flatsOutletCollection[currentNoteButton.tag - 1]
//            currentFlat.setImage(UIImage(named: "flat"), for: .normal)
            
            for sharp in sharpsOutletCollection {
                if sharp.tag == currentNoteButton.tag && sharp.currentImage != UIImage(named: "sharp_wrong") {
                    sharp.setImage(UIImage(named: "sharp"), for: .normal)
                    print("setting sharp image back to normal")
                }
            }

            for flat in flatsOutletCollection {
                if flat.tag == currentNoteButton.tag && flat.currentImage != UIImage(named: "flat_wrong") {
                    flat.setImage(UIImage(named: "flat"), for: .normal)
                }
            }
            
        }
        
        var panGestureOver: Bool = false
        
        func checkIfStateEnded(onSharpOrFlat: Accidentals) -> Bool {
            
            if recognizer.state == .ended {
                
                switch onSharpOrFlat {
                    
                case .flat:
                    currentAccidental = .flat
                    currentUserAnswer = "\(currentUserAnswer)b"
                    let image = UIImage(named: "\(currentUserAnswer)_default")
                    currentNoteButton.setImage(image, for: UIControl.State.normal)

                    return true
                    
                case .sharp:
                    currentAccidental = .sharp
                    currentUserAnswer = "\(currentUserAnswer)#"
                    let image = UIImage(named: "\(currentUserAnswer)_default")
                    currentNoteButton.setImage(image, for: UIControl.State.normal)

                    return true
                    
                case .neither:
                    
                    currentAccidental = .neither
                    let image = UIImage(named: "\(currentUserAnswer)_default")
                    currentNoteButton.setImage(image, for: UIControl.State.normal)
                    
                    return true
                    
                }
                
            }
            
            return false
            
        }
        
        let image = UIImage(named: "\(currentUserAnswer)_pressed")
        currentNoteButton.setImage(image, for: UIControl.State.normal)
        
        // recognize flat
        if recognizerWithinFlatRange {
            
            panGestureOver = checkIfStateEnded(onSharpOrFlat: .flat)
            
            if panGestureOver { checkAnswer() }
            
        // recognize sharp
        } else if recognizerWithinSharpRange {
            
            panGestureOver = checkIfStateEnded(onSharpOrFlat: .sharp)
            
            if panGestureOver { checkAnswer() }
            
        // if landed withing the current button range
        } else if recognizerWithinNoteButtonRange {
            
            panGestureOver = checkIfStateEnded(onSharpOrFlat: .neither)

            if panGestureOver { checkAnswer() }
        
        // if landed outside the current button range
        } else if !recognizerWithinNoteButtonRange {
            
            panGestureOver = checkIfStateEnded(onSharpOrFlat: .neither)
            
        }
//        else {
//
//            panGestureOver = checkIfStateEnded(onSharpOrFlat: .neither)
//
//            if panGestureOver {
//                //                currentUserAnswer = "\(currentUserAnswer)#"
//                //                print(currentUserAnswer)
//
//                checkAnswer()
//            }
//
//        }
        
    }
    
    //  figure out which button is sending the translation message
    //  get coordinates of the triangle button (as a variable -- changes with size right?)
    //  make sure buttons look correct depending on user action
    
    //        checkIfStateEnded()
    
    // when pan gesture is over, reset the button
    //        } else if recognizer.state == .ended {
    //
    //            let image = UIImage(named: "\(currentUserAnswer)_default")
    //            currentNoteButton.setImage(image, for: UIControl.State.normal)
    //
    //        }
    // use tag to identify button?
    //        print(recognizer.view?.tag)
    
    
    
//    func play(sound: String, ofType type: SoundExtension) {
////        print("1: \(notificationSoundLookupTable)")
//        if let soundID = notificationSoundLookupTable[sound] {
//            AudioServicesPlaySystemSound(soundID)
////            print("2: \(notificationSoundLookupTable)")
////            print("this happened!")
//        } else {
////            print("3: \(notificationSoundLookupTable)")
//            if let soundURL : CFURL = Bundle.main.url(forResource: sound, withExtension: type.rawValue) as CFURL? {
//                var soundID  : SystemSoundID = 0
//                let osStatus : OSStatus = AudioServicesCreateSystemSoundID(soundURL, &soundID)
//                if osStatus == kAudioServicesNoError {
//                    AudioServicesPlaySystemSound(soundID);
//                    notificationSoundLookupTable[sound] = (soundID)
//                } else {
////                    print("This is the osStatus error thing!")
//                    // This happens in exceptional cases
//                    // Handle it with no sound or retry
//                }
//            } else {
//                print("some problem with sound \(sound)")
//            }
//        }
//    }
    
//    func disposeSoundIDs() {
//        for soundID in notificationSoundLookupTable.values {
//            AudioServicesDisposeSystemSoundID(soundID)
//        }
//    }
    
    // REFACTOR:
    
    @IBAction func noteA(_ sender: UIButton) {
        checkAnswer()
    }
    
    @IBAction func noteB(_ sender: UIButton) {
        checkAnswer()
    }

    @IBAction func noteC(_ sender: UIButton) {
        checkAnswer()
    }
    
    @IBAction func noteD(_ sender: UIButton) {
        checkAnswer()
    }
    
    @IBAction func noteE(_ sender: UIButton) {
        checkAnswer()
    }
    
    @IBAction func noteF(_ sender: UIButton) {
        checkAnswer()
    }
    
    @IBAction func noteG(_ sender: UIButton) {
        checkAnswer()
    }

    @IBAction func touchDownA(_ sender: UIButton) {
        currentUserAnswer = "A"
        currentNoteButton = noteButtonA
        setCurrentNoteXBounds()
    }
    
    @IBAction func touchDownB(_ sender: UIButton) {
        currentUserAnswer = "B"
        currentNoteButton = noteButtonB
        setCurrentNoteXBounds()
    }
    
    @IBAction func touchDownC(_ sender: UIButton) {
        currentUserAnswer = "C"
        currentNoteButton = noteButtonC
        setCurrentNoteXBounds()
    }
    
    @IBAction func touchDownD(_ sender: UIButton) {
        currentUserAnswer = "D"
        currentNoteButton = noteButtonD
        setCurrentNoteXBounds()
    }
    
    @IBAction func touchDownE(_ sender: UIButton) {
        currentUserAnswer = "E"
        currentNoteButton = noteButtonE
        setCurrentNoteXBounds()
    }
    
    @IBAction func touchDownF(_ sender: UIButton) {
        currentUserAnswer = "F"
        currentNoteButton = noteButtonF
        setCurrentNoteXBounds()
    }
    
    @IBAction func touchDownG(_ sender: UIButton) {
        currentUserAnswer = "G"
        currentNoteButton = noteButtonG
        setCurrentNoteXBounds()
    }
    
    func setCurrentNoteXBounds() {
        noteButtonLowerBoundX = currentNoteButton.bounds.minX
        noteButtonUpperBoundX = currentNoteButton.bounds.maxX
    }
    
    func setupGameForCurrentLevel() {
        
        disableButtons()
        
        // note choices
        currentNoteChoices = Level.currentLevel.noteChoices
        
        // set the keys to display
        let currentLevelID = Level.currentLevel.id
        
        switch currentLevelID {
        case 1:
            setToOnlyCDE()
            disableSharps()
            sharpsViewOutlet.alpha = 0
            disableFlats()
            flatsViewOutlet.alpha = 0
            disableGestureRecognizers()
        case 2:
            setToOnlyFGAB()
            disableSharps()
            sharpsViewOutlet.alpha = 0
            disableFlats()
            flatsViewOutlet.alpha = 0
            disableGestureRecognizers()
        case 3:
            setToOnlyWhiteKeys()
            disableSharps()
            sharpsViewOutlet.alpha = 0
            disableFlats()
            flatsViewOutlet.alpha = 0
            disableGestureRecognizers()
        case 4:
            setToOnlyBlackKeys()
            enableSharps()
            sharpsViewOutlet.alpha = 1
            disableFlats()
            flatsViewOutlet.alpha = 0
            enableGestureRecognizers()
        case 5:
            setToOnlyBlackKeys()
            disableSharps()
            sharpsViewOutlet.alpha = 0
            enableFlats()
            flatsViewOutlet.alpha = 1
            enableGestureRecognizers()
        case 6:
            setToAllNoteChoices()
            enableSharps()
            sharpsViewOutlet.alpha = 1
            enableFlats()
            flatsViewOutlet.alpha = 1
            enableGestureRecognizers()
        case 7:
            setToAllNoteChoices()
            enableSharps()
            sharpsViewOutlet.alpha = 1
            enableFlats()
            flatsViewOutlet.alpha = 1
            enableGestureRecognizers()
        default: break
        }
        
        enableButtons()
        
        // determine next level
        
    }
    
    func enableSharps() {
        for sharp in sharpsOutletCollection {
            sharp.isEnabled = true
        }
    }
    
    func disableSharps() {
        for sharp in sharpsOutletCollection {
            sharp.isEnabled = false
        }
    }
    
    func enableFlats() {
        for flat in flatsOutletCollection {
            flat.isEnabled = true
        }
    }
    
    func disableFlats() {
        for flat in flatsOutletCollection {
            flat.isEnabled = false
        }
    }

    func enableGestureRecognizers() {
        for panGestureRecognizer in panGestureRecognizersCollection {
            panGestureRecognizer.isEnabled = true
        }
    }
    
    func disableGestureRecognizers() {
        for panGestureRecognizer in panGestureRecognizersCollection {
            panGestureRecognizer.isEnabled = false
        }
    }
    
    func enableOrDisableWhiteKeys() {
        whiteKeyButtons[0].isEnabled = false
        whiteKeyButtons[17].isEnabled = false
    }
    
    func enableWhiteKeyButtons() {
        for index in 1...16 {
            whiteKeyButtons[index].isEnabled = true
        }
    }
    
    func disableWhiteKeyButtons() {
        for index in 1...16 {
            whiteKeyButtons[index].isEnabled = false
        }
    }
    
    func enableBlackKeyButtons() {
        for blackKeyButton in blackKeyButtons {
            if let currentBlackKeyButtonIdentifier = blackKeyButton.accessibilityIdentifier {
                if (0...12).contains(Int(currentBlackKeyButtonIdentifier)!) {
                    blackKeyButton.isEnabled = true
                }
            }
        }
    }
    
    func disableBlackKeyButtons() {
        for blackKeyButton in blackKeyButtons {
            if let currentBlackKeyButtonIdentifier = blackKeyButton.accessibilityIdentifier {
                if (0...12).contains(Int(currentBlackKeyButtonIdentifier)!) {
                    blackKeyButton.isEnabled = false
                }
            }
        }
    }
    
    func calculateSharpAndFlatBounds() {
        // calculate shaprs & flats bounds for pan gesture recognition
        sharpsUpperBound = sharpsViewOutlet.bounds.maxY + 5
        sharpsLowerBound = sharpsViewOutlet.bounds.minY - 10
        
        flatsUpperBound = flatsViewOutlet.bounds.maxY + 10
        flatsLowerBound = flatsViewOutlet.bounds.minY - 5
        
        // calculate note button bounds for pan gesture recognition
        noteButtonUpperBoundY = noteButtonD.bounds.maxY
        noteButtonLowerBoundY = noteButtonD.bounds.minY
    }
    
}
