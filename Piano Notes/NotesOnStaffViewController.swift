//
//  NotesOnStaffViewController.swift
//  Piano Notes
//
//  Created by Matvey on 5/15/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit
import AVFoundation

class NotesOnStaffViewController: UIViewController {
    
    
    @IBOutlet weak var noteOnStaffImage: UIImageView!
    
    @IBOutlet weak var accidentalsButtonsOutlet: UIStackView!
    
    @IBOutlet weak var arrowAndCheckButtonsOutlet: UIStackView!
    
    @IBOutlet weak var topLabelOutlet: UIImageView!
    
    
    @IBOutlet weak var pianoBackgroundOutlet: UIImageView!
    
    @IBOutlet weak var pianoNoteDisplayed: UIImageView!
    
    var currentNoteOnStaffImageName = ""
    
    @IBOutlet var panGestureRecognizerOutlet: UIPanGestureRecognizer!
    
    @IBOutlet weak var allKeyButtons: UIView!
    
    @IBOutlet var keyButtonsOutletCollection: [UIButton]!
    
    @IBAction func keyButtonTouchUpInside(_ sender: UIButton) {
        print("\(sender.tag): \(allNotesOnLargeKeyboard[sender.tag])")
        
        checkAnswer()
    }
    
    @IBAction func keyButtonTouchDown(_ sender: UIButton) {
        currentUserAnswer = allNotesOnLargeKeyboard[sender.tag]
        
        pianoNoteDisplayed.image = UIImage(named: "large_\(currentUserAnswer)_pressed")
    }
    
    
    @IBAction func keyButtonDraggedOutside(_ sender: UIButton) {
    }
    
    @IBAction func sharpButtonPressed(_ sender: UIButton) {
        
        let currentNoteOnStaffImageNameSecondToLastCharacter = currentNoteOnStaffImageName[currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -2)]
        
        print("currentNoteOnStaffImageName: \(currentNoteOnStaffImageName), currentNoteOnStaffImageNameSecondToLastCharacter: \(currentNoteOnStaffImageNameSecondToLastCharacter)")
        
        if  currentAccidental == .neither {
            
            currentAccidental = .sharp
            
            if currentNoteOnStaffImageName.contains("Bass") {
                currentNoteOnStaffImageName.insert("#", at: currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -5))
            } else {
                currentNoteOnStaffImageName.insert("#", at: currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -1))
            }
            
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
            
        } else if currentAccidental == .flat {
            
            currentAccidental = .sharp
            
            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "b", with: "#")
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
        }
        
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
        
    }
    
    @IBAction func flatButtonPressed(_ sender: UIButton) {
        
        let currentNoteOnStaffImageNameSecondToLastCharacter = currentNoteOnStaffImageName[currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -2)]
        
        print("currentNoteOnStaffImageName: \(currentNoteOnStaffImageName), currentNoteOnStaffImageNameSecondToLastCharacter: \(currentNoteOnStaffImageNameSecondToLastCharacter)")
        
        if  currentAccidental == .neither {
            
            currentAccidental = .flat
            
            if currentNoteOnStaffImageName.contains("Bass") {
                currentNoteOnStaffImageName.insert("b", at: currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -5))
            } else {
                currentNoteOnStaffImageName.insert("b", at: currentNoteOnStaffImageName.index(currentNoteOnStaffImageName.endIndex, offsetBy: -1))
            }
            
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
            
        } else if currentAccidental == .sharp {
            
            currentAccidental = .flat
            
            currentNoteOnStaffImageName = currentNoteOnStaffImageName.replacingOccurrences(of: "#", with: "b")
            updateNoteOnStaffImage(optionalImageName: currentNoteOnStaffImageName)
        }
        
    }
    
    @IBAction func upArrowButtonPressed(_ sender: UIButton) {
        if currentNoteOnStaffIndex < whiteNotesOnLargeKeyboard.count - 1 {
            currentNoteOnStaffIndex += 1
            updateNoteOnStaffImage(optionalImageName: nil)
            currentAccidental = .neither
        }
    }
    
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    var userAnswer = ""
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        userAnswer = currentNoteOnStaffImageName
        print("userAnswer: \(userAnswer)")
        checkAnswer()
        
        // generate new note; be sure to reset the accidental!
    }
    
    @IBAction func downArrowButtonPressed(_ sender: UIButton) {
        if currentNoteOnStaffIndex > 0 {
            currentNoteOnStaffIndex -= 1
            updateNoteOnStaffImage(optionalImageName: nil)
            currentAccidental = .neither
        }
    }
    

    // placeholder variables for comparing answers
    var currentCorrectAnswer = ""
    var currentUserAnswer = ""

    // do I need this?
//    // placeholder for current note
//    var currentNote = ""
    
    @IBOutlet weak var scoreLabelOutlet: UILabel!
    
    @IBOutlet weak var starsImageOutlet: UIImageView!
    
    // MARK: - MENU
    
    @IBOutlet weak var menuButtonOutlet: UIButton!
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        
        menuIsClosed ? openMenu() : closeMenu()
        
    }
    
    @IBOutlet weak var menuContainerOutlet: UIView!
    
    @IBOutlet weak var menuTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var darkOverlayOutlet: UIButton!
    
    @IBAction func darkOverlayTapped(_ sender: UIButton) {
        closeMenu()
    }
    
    // MARK: - MENU ITEMS
    
    // TODO: change the top label, and change its size as well? or re-implement using an actual label?
    
    @IBOutlet weak var currentLevelOutlet: UILabel!
    
    @IBOutlet weak var modeSwitchOutlet: CustomSwitch!
    
    @IBOutlet weak var levelAndModeStack: UIStackView!
    @IBOutlet weak var modeStack: UIStackView!
    
    
    
    @IBAction func customModeSwitchFlipped(_ sender: CustomSwitch) {
        switchModes()
    }
    
    @IBAction func modeSegmentedControl(_ sender: UISegmentedControl) {
        switchModes()
    }
    
    
    @IBOutlet weak var enableAccidentalsSwitchOutlet: UISwitch!
    
    @IBAction func enableAccidentalsSwitchFlipped(_ sender: UISwitch) {
        if sender.isOn {
            // TODO: - INSTEAD OF JUST SETTING TO ALL NOTE CHOICES, SET TO
            // CURRENT NOTE CHOICES + THE ACCIDENTALS IN BETWEEN!
            // BUT THEN THERE SHOULD BE A SHORTCUT FOR ALL NOTE CHOICES?
            setToAllNotesOnStaff()
            
            accidentalsSegmentedControlOutlet.selectedSegmentIndex = 0
            onlyTrebleClefSwitchOutlet.isOn = false
            onlyBassClefSwitchOutlet.isOn = false
            onlyGuideNotesSwitchOutlet.isOn = false
            onlyMnemonicsSwitchOutlet.isOn = false
        } else {
            setToAllWhiteKeys()
        }
    }
    
    @IBOutlet weak var accidentalsSegmentedControlOutlet: UISegmentedControl!
    
    
    @IBAction func accidentalsSegmentedControl(_ sender: UISegmentedControl) {
        
        enableAccidentalsSwitchOutlet.isOn = true
        
        if sender.selectedSegmentIndex == 0 {
            
            allAccidentalsEnabled = true
            onlySharpsEnabled = false
            onlyFlatsEnabled = false
            
        } else if sender.selectedSegmentIndex == 1 {
            
            allAccidentalsEnabled = false
            onlySharpsEnabled = true
            onlyFlatsEnabled = false
       
        } else {
            
            allAccidentalsEnabled = false
            onlySharpsEnabled = false
            onlyFlatsEnabled = true
            
        }
    }
    
    @IBAction func onlyTrebleClefSwitchFlipped(_ sender: UISwitch) {
        if sender.isOn {
            
            if enableAccidentalsSwitchOutlet.isOn {
                onlyTrebleClefSegmentedControlOutlet.selectedSegmentIndex = 0
                setToOnlyTrebleClef()
            } else {
                onlyTrebleClefSegmentedControlOutlet.selectedSegmentIndex = 1
                setToOnlyTrebleClefWhiteKeys()
            }
            
            updateNoteRangeImages()
            
            onlyBassClefSwitchOutlet.isOn = false
            onlyGuideNotesSwitchOutlet.isOn = false
            onlyMnemonicsSwitchOutlet.isOn = false
            
        } else {
            setToPreviousNoteChoices()
            onlyTrebleClefSegmentedControlOutlet.selectedSegmentIndex = 0
            onlyBassClefSegmentedControlOutlet.selectedSegmentIndex = 0
        }
    }
    
    @IBOutlet weak var onlyTrebleClefSwitchOutlet: UISwitch!
    
    @IBAction func onlyTrebleClefSegmentedControl(_ sender: UISegmentedControl) {
        
        onlyTrebleClefSwitchOutlet.isOn = true
        onlyBassClefSwitchOutlet.isOn = false
        
        if sender.selectedSegmentIndex == 0 {
            
            setToOnlyTrebleClef()
            
        } else if sender.selectedSegmentIndex == 1 {
            
            setToOnlyTrebleClefWhiteKeys()
            enableAccidentalsSwitchOutlet.isOn = false
            
        } else {
            
            setToOnlyTrebleClefBlackKeys()
            enableAccidentalsSwitchOutlet.isOn = true
            accidentalsSegmentedControlOutlet.selectedSegmentIndex = 0
            
        }
    }
    
    @IBOutlet weak var onlyTrebleClefSegmentedControlOutlet: UISegmentedControl!
    
    @IBAction func onlyBassClefSwitchFlipped(_ sender: UISwitch) {
        if sender.isOn {
            
            if enableAccidentalsSwitchOutlet.isOn {
                onlyBassClefSegmentedControlOutlet.selectedSegmentIndex = 0
                setToOnlyBassClef()
            } else {
                onlyBassClefSegmentedControlOutlet.selectedSegmentIndex = 1
                setToOnlyBassClefWhiteKeys()
            }
            
            updateNoteRangeImages()
            
            onlyTrebleClefSwitchOutlet.isOn = false
            onlyGuideNotesSwitchOutlet.isOn = false
            onlyMnemonicsSwitchOutlet.isOn = false
        } else {
            setToPreviousNoteChoices()
            onlyTrebleClefSegmentedControlOutlet.selectedSegmentIndex = 0
            onlyBassClefSegmentedControlOutlet.selectedSegmentIndex = 0
        }
    }
    
    @IBOutlet weak var onlyBassClefSwitchOutlet: UISwitch!
    
    @IBAction func onlyBassClefSegmentedControl(_ sender: UISegmentedControl) {
        
        onlyBassClefSwitchOutlet.isOn = true
        onlyTrebleClefSwitchOutlet.isOn = false
        
        if sender.selectedSegmentIndex == 0 {
            
            setToOnlyBassClef()
            
        } else if sender.selectedSegmentIndex == 1 {
            
            setToOnlyBassClefWhiteKeys()
            enableAccidentalsSwitchOutlet.isOn = false
            
        } else {
            
            setToOnlyBassClefBlackKeys()
            enableAccidentalsSwitchOutlet.isOn = true
            accidentalsSegmentedControlOutlet.selectedSegmentIndex = 0
            
        }
    }
    
    @IBOutlet weak var onlyBassClefSegmentedControlOutlet: UISegmentedControl!
    
    
    @IBOutlet weak var noteRangeLowNoteImage: UIImageView!
    
    @IBOutlet weak var noteRangeHighNoteImage: UIImageView!

    
    @IBAction func noteRangeLowNoteUp(_ sender: UIButton) {
        
        if lowNoteIndex < highNoteIndex - 1 {
            currentNoteChoices.removeFirst()
            print("currentNoteChoices: \(currentNoteChoices)")
            
            
            updateNoteIndices()
            
            noteRangeLowNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[lowNoteIndex])")
        }
    }
    
    @IBAction func noteRangeLowNoteDown(_ sender: UIButton) {
        
        if lowNoteIndex < 15 {
            onlyTrebleClefBlackNotesEnabled = false
            onlyTrebleClefSwitchOutlet.isOn = false
            onlyTrebleClefSegmentedControlOutlet.selectedSegmentIndex = 0
        }
        
        if lowNoteIndex > 0 {
            
            if allAccidentalsEnabled {
                let tempLowestNoteIndex = allNotesOnLargeKeyboardForVariousSettings.index(of: currentNoteChoices.first!)!
                currentNoteChoices.insert(allNotesOnLargeKeyboardForVariousSettings[tempLowestNoteIndex - 1], at: 0)
            } else {
                let tempLowestNoteIndex = whiteNotesOnLargeKeyboard.index(of: currentNoteChoices.first!)!
                currentNoteChoices.insert(whiteNotesOnLargeKeyboard[tempLowestNoteIndex - 1], at: 0)
            }
            
            updateNoteIndices()
            
            noteRangeLowNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[lowNoteIndex])")
            
        }
    }
    
    @IBAction func noteRangeHighNoteUp(_ sender: UIButton) {
        
        if highNoteIndex > 14 {
            onlyBassClefBlackNotesEnabled = false
            onlyBassClefSwitchOutlet.isOn = false
            onlyBassClefSegmentedControlOutlet.selectedSegmentIndex = 0
        }
        
        if highNoteIndex < whiteNotesOnLargeKeyboard.count - 1 {
            
            if allAccidentalsEnabled {
                let tempHighestNoteIndex = allNotesOnLargeKeyboardForVariousSettings.index(of: currentNoteChoices.last!)!
                currentNoteChoices.append(allNotesOnLargeKeyboardForVariousSettings[tempHighestNoteIndex + 1])
            } else {
                let tempHighestNoteIndex = whiteNotesOnLargeKeyboard.index(of: currentNoteChoices.last!)!
                currentNoteChoices.append(whiteNotesOnLargeKeyboard[tempHighestNoteIndex + 1])
            }
            
            updateNoteIndices()
            
            noteRangeHighNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[highNoteIndex])")
        
        }
    }
    
    @IBAction func noteRangeHighNoteDown(_ sender: UIButton) {
        if highNoteIndex > lowNoteIndex + 1 {
            
            currentNoteChoices.removeLast()
            print("currentNoteChoices: \(currentNoteChoices)")
            
            updateNoteIndices()
            
            noteRangeHighNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[highNoteIndex])")
            
        }
    }
    
    @IBAction func onlyGuideNotesSwitchFlipped(_ sender: UISwitch) {
        if sender.isOn {
            setToOnlyGuideNotes()
            updateNoteRangeImages()
            
            enableAccidentalsSwitchOutlet.isOn = false
            onlyTrebleClefSwitchOutlet.isOn = false
            onlyBassClefSwitchOutlet.isOn = false
            onlyMnemonicsSwitchOutlet.isOn = false
            
            onlyTrebleClefSegmentedControlOutlet.selectedSegmentIndex = 1
            onlyBassClefSegmentedControlOutlet.selectedSegmentIndex = 1
        } else {
            setToPreviousNoteChoices()
        }
    }
    
    @IBOutlet weak var onlyGuideNotesSwitchOutlet: UISwitch!
    
    
    @IBAction func onlyMnemonicsSwitchFlipped(_ sender: UISwitch) {
        if sender.isOn {
            setToOnlyMnemonics()
            updateNoteRangeImages()
            
            enableAccidentalsSwitchOutlet.isOn = false
            onlyTrebleClefSwitchOutlet.isOn = false
            onlyBassClefSwitchOutlet.isOn = false
            onlyGuideNotesSwitchOutlet.isOn = false
            
            onlyTrebleClefSegmentedControlOutlet.selectedSegmentIndex = 1
            onlyBassClefSegmentedControlOutlet.selectedSegmentIndex = 1
        } else {
            setToPreviousNoteChoices()
        }
    }
    
    @IBOutlet weak var onlyMnemonicsSwitchOutlet: UISwitch!
    
//    @IBAction func onlyMnemonicsSegmentedControl(_ sender: UISegmentedControl) {
//    }
//    
//    @IBOutlet weak var onlyMnemonicsSegmentedControlOutlet: UISegmentedControl!
    
    @IBAction func enableSoundsSwitchFlipped(_ sender: UISwitch) {
        if !sender.isOn {
            soundsEnabled = false
        } else {
            soundsEnabled = true
        }
    }
    
    @IBOutlet weak var enableSoundsSwitchOutlet: UISwitch!
    
    
    @IBAction func reEnableExplainersSwitchFlipped(_ sender: UISwitch) {
        if !sender.isOn {
            explainersEnabledNoteNames = false
            explainersEnabledNotesOnStaff = false
        } else {
            explainersEnabledNoteNames = true
            explainersEnabledNotesOnStaff = true
        }
    }
    
    var noteRangeImageHeight: Double = 0
    var noteRangeImageLocationAdjustment: Double = 0
    var noteRangeLocationFactor: Double = 0
    
    var noteOnStaffImageHeight: Double = 0
    var noteOnStaffImageLocationAdjustment: Double = 0
    var noteOnStaffLocationFactor: Double = 0
    
    // REFACTOR SOME (MOST?) OF THIS TO viewDidAppear() ?!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let angleIncrement = 0.001
        
        keyButtonsOutletCollection.sort(by: {$0.tag < $1.tag})

        
        for index in (0...24).reversed() {
            keyButtonsOutletCollection[index].transform = CGAffineTransform(rotationAngle: CGFloat(Double(24 - index) * angleIncrement))
            keyButtonsOutletCollection[49 - index].transform = CGAffineTransform(rotationAngle: CGFloat(Double(24 - index) * -angleIncrement))
        }
        
        pianoNoteDisplayed.alpha = 1
        
        currentAccidental = .neither
        updateNoteOnStaffImage(optionalImageName: nil)
        
        
        scoreLabelOutlet.text = "0"
        
        menuContainerOutlet.alpha = 0
        menuTrailingConstraint.constant = 550
        
        noteRangeImageHeight = Double(noteRangeLowNoteImage.bounds.height)
        noteRangeLocationFactor = 0.8 * (noteRangeImageHeight) / Double(whiteNotesOnLargeKeyboard.count)
        noteRangeImageLocationAdjustment = 0.09 * noteRangeImageHeight
        
        noteOnStaffImageHeight = Double(noteOnStaffImage.bounds.height)
        noteOnStaffLocationFactor = 0.8 * (noteOnStaffImageHeight) / Double(whiteNotesOnLargeKeyboard.count)
        noteOnStaffImageLocationAdjustment = 0.09 * noteOnStaffImageHeight
        
        // TODO: - Change this depending on level
//        currentNoteChoices = allNotesOnLargeKeyboard
//        setRandomNewNoteUpperIndex()
    }
    
    // indices for note range settings in menu
//    var lowNoteIndex = 0
//    var highNoteIndex = whiteNotesOnLargeKeyboard.count - 1
    
    override func viewWillAppear(_ animated: Bool) {
        currentNoteChoices = Level.currentLevel.noteChoices
        previousNoteChoices = currentNoteChoices
        
        currentGameMode = .A
        
        modeStack.alpha = 1
        
        switch Level.currentLevel.id {
        case -1:
            menuButtonOutlet.alpha = 1
            levelAndModeStack.alpha = 0
            modeSwitchOutlet.setOn(on: false, animated: false)
            enableAccidentalsSwitchOutlet.isOn = true
            setToAllNotesOnStaff()
            setupForModeA()
        case 0:
            menuButtonOutlet.alpha = 1
            levelAndModeStack.alpha = 0
            modeSwitchOutlet.setOn(on: true, animated: false)
            enableAccidentalsSwitchOutlet.isOn = true
            setToAllNotesOnStaff()
            setupForModeB()
        case 8:
            modeSwitchOutlet.setOn(on: true, animated: false)
            setupForModeB()
        case 13:
            modeSwitchOutlet.setOn(on: true, animated: false)
            modeStack.alpha = 0
            setupForModeB()
        default:
            modeSwitchOutlet.setOn(on: false, animated: false)
            setupForModeA()
        }
        
        currentLevelOutlet.text = String(Level.currentLevel.id)
        
        print("currentNoteChoices: \(currentNoteChoices)")
        setRandomNewNoteUpperIndex()
        
        updateNoteIndices()
//        generateNewNote()
        
        noteRangeLowNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[lowNoteIndex])")
        noteRangeHighNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[highNoteIndex])")
        
        startNewRound()
        
        if soundsEnabled {
            enableSoundsSwitchOutlet.isOn = true
        } else {
            enableSoundsSwitchOutlet.isOn = false
        }
    }
    
    var locationTracker: Double = Double(whiteNotesOnLargeKeyboard.count / 2) {
        didSet {
            currentNoteOnStaffIndex = Int(round(locationTracker))
            updateNoteOnStaffImage(optionalImageName: nil)
            currentAccidental = .neither
        }
    }
    
    func updateNoteOnStaffImage(optionalImageName: String?) {
        if let imageName = optionalImageName {
            noteOnStaffImage.image = UIImage(named: imageName)
        } else {
            currentNoteOnStaffImageName = "staff\(whiteNotesOnLargeKeyboard[currentNoteOnStaffIndex])"
            noteOnStaffImage.image = UIImage(named: currentNoteOnStaffImageName)
        }
        print("currentNoteOnStaffImageName: \(currentNoteOnStaffImageName)")
        print("locationTracker: \(locationTracker)")
        print("currentNoteIndex: \(currentNoteOnStaffIndex)")

    }
    
    // for keeping track of piano keys already tried
    var notesAlreadyAttempted = [String]()
    
    var showAlertAtFiveStars = true
    
    func checkAnswer() {
        
        // DO I STILL NEED THIS?
        print("currentNoteOnStaffImageName: \(currentNoteOnStaffImageName)")
        
        if currentCorrectAnswer == "C4Bass" {
            currentCorrectAnswer = "C4"
        } else if currentCorrectAnswer == "C#4Bass" {
            currentCorrectAnswer = "C#4"
        } else if currentCorrectAnswer == "Cb4Bass" {
            currentCorrectAnswer = "B3"
        }
        
        // DEAL WITH C4bass, C#4bass, etc (is there an etc?)
        print("going into checkAnswer, currentNoteOnStaffImageName is: \(currentNoteOnStaffImageName)")
        if currentNoteOnStaffImageName.hasSuffix("Bass") {
            currentNoteOnStaffImageName.removeLast(4)
            print("and now, currentNoteOnStaffImageName is: \(currentNoteOnStaffImageName)")
        }
        
        if currentGameMode == .A {
        
            currentUserAnswer = currentAccidental == .neither ? String(currentNoteOnStaffImageName.suffix(2)) : String(currentNoteOnStaffImageName.suffix(3))
            print("currentUserAnswer: \(currentUserAnswer)")
        
        }
        
        let currentUserAnswerWithoutOctave = currentAccidental == .neither ? String(currentUserAnswer.prefix(1)) : String(currentUserAnswer.prefix(2))
        
        print("currentUserAnswerWithoutOctave: \(currentUserAnswerWithoutOctave)")
        
        
        
        var currentEnharmonic: String? = getEnharmonic(currentNote: currentUserAnswerWithoutOctave)
        
        // deal with octave difference in a B#3 = C4 kind of situation
        if currentEnharmonic != nil {
            
            if currentUserAnswer == "B#2" ||
               currentUserAnswer == "B#3" ||
               currentUserAnswer == "B#4" ||
               currentUserAnswer == "B#5" {
                
                currentEnharmonic! += String(Int(currentUserAnswer.suffix(1))! + 1)

            } else if currentUserAnswer == "Cb3" ||
                      currentUserAnswer == "Cb4" ||
                      currentUserAnswer == "Cb5" ||
                      currentUserAnswer == "Cb6" {
                
                currentEnharmonic! += String(Int(currentUserAnswer.suffix(1))! - 1)
                
            } else {
            
                currentEnharmonic! += String(currentUserAnswer.suffix(1))
                
            }
            
        }
        
        print("currentCorrectAnswer: \(currentCorrectAnswer)")
        print("currentEnharmonic: \(currentEnharmonic)")
        print("currentUserAnswer: \(currentUserAnswer)")
        
        // RIGHT ANSWER
        if currentUserAnswer == currentCorrectAnswer || currentEnharmonic == currentCorrectAnswer {
            print("correct!")
            
            switch currentGameMode {
            case .A:
                checkButtonOutlet.setImage(UIImage(named: "check_right"), for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
                    self.checkButtonOutlet.setImage(UIImage(named: "check"), for: .normal)
                    self.generateNewNote()
                })
            case .B:
                print("CORRECT - CASE B!")
                pianoNoteDisplayed.image = UIImage(named: "large_\(currentCorrectAnswer)_right")
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
                    self.generateNewNote()
                })
            }
            
            
            // play sound
            if soundsEnabled {
                
//                switch currentGameMode {
//                case .A: loadSound(currentSound: currentNote)
//                case .B: loadSound(currentSound: nameOfKeyToHighlight)
//                }
                
                loadSound(currentSound: "\(currentCorrectAnswer)")
                
                audioPlayer!.play()
                audioPlayer!.setVolume(0, fadeDuration: 2.5)
            }
            
            // update score
            totalScore += 1
            correctAnswersInARow += 1
            incorrectAnswersInARow = 0
            giveOrTakeAStar()
            starsImageOutlet.image = UIImage(named: "stars\(currentNumberOfStars)")
            
            if currentNumberOfStars == 5 && Level.currentLevel.id > 0 && showAlertAtFiveStars {
                Alert.showFinishLevelAlert(on: self)
                levelsCompleted.append(Level.currentLevel.id)
                appDataForCurrentUser.levelsCompleted = levelsCompleted
                print("dataToSaveForCurrentUser.levelsCompleted: \(appDataForCurrentUser.levelsCompleted)")
                showAlertAtFiveStars = false 
//                AppData.saveToFile(dataToSave: appDataForCurrentUser)
            }
            
        // WRONG ANSWER
        } else {
            print("incorrect!")
            // play "wrong" sound
            if soundsEnabled {
                loadSound(currentSound: "wrong")
                audioPlayer!.play()
                audioPlayer!.setVolume(0.05, fadeDuration: 0)
            }
            
            switch currentGameMode {
            case .A:
                checkButtonOutlet.setImage(UIImage(named: "check_wrong"), for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
                    self.checkButtonOutlet.setImage(UIImage(named: "check"), for: .normal)
                })
            case .B:
                pianoNoteDisplayed.image = nil
                
                if !notesAlreadyAttempted.contains(currentUserAnswer) {
                    
                    let wrongNoteImageName = "large_\(currentUserAnswer)_wrong"
                    let wrongNoteImage = UIImage(named: wrongNoteImageName)
                    let wrongNoteImageView = UIImageView(image: wrongNoteImage!)
                    
                    addSameSize(subview: wrongNoteImageView, onTopOf: pianoNoteDisplayed)
                    
                }
                
                notesAlreadyAttempted.append(currentUserAnswer)
 
            }
            
            
            
            // subtract a point
            if totalScore > 0 {
                totalScore -= 1
            }
            
            // flash score label red #FF3939
            self.scoreLabelOutlet.textColor = UIColor(red:1.00, green:0.22, blue:0.22, alpha:1.0)
            // bring it back to green after a second
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
                self.scoreLabelOutlet.textColor = UIColor(red:0.50, green:0.96, blue:0.00, alpha:1.0)
            })
            
            correctAnswersInARow = 0
            incorrectAnswersInARow += 1
            giveOrTakeAStar()
            starsImageOutlet.image = UIImage(named: "stars\(currentNumberOfStars)")
        
        }
        
        scoreLabelOutlet.text = String(totalScore)

    }
    
    var lastAccidentalOrNotIndex: Int = -1
    var accidentalOrNot: Accidentals = .neither
    
    func generateNewNote() {
      
        generateNewRandomNoteIndex()
        lastRandomNumber = randomNewNoteIndex
        
        pianoNoteDisplayed.image = nil
        
        // remove notes marked wrong
        if !notesAlreadyAttempted.isEmpty {
            for subview in self.pianoNoteDisplayed.subviews {
                subview.removeFromSuperview()
            }
        }
        
        notesAlreadyAttempted = [""]
        
        if currentGameMode == .A {
            
            currentCorrectAnswer = currentNoteChoices[randomNewNoteIndex]
            
            if currentCorrectAnswer == "C4bass" {
                pianoNoteDisplayed.image = UIImage(named: "large_C4_shown")
            } else {
                pianoNoteDisplayed.image = UIImage(named: "large_\(currentCorrectAnswer)_shown")
            }
        
        // MODE B
        } else {
            
            print("currentNoteChoices in generateNewNote(): \(currentNoteChoices)")
            
            if allAccidentalsEnabled {
                
                if currentNoteChoices[randomNewNoteIndex].contains("#") {
                
                    let randomSharpOrFlat = Int.random(in: 0...1)
                    
                    // flat
                    if randomSharpOrFlat == 1 {
                        
                        var currentTempNoteNameWithOctave = currentNoteChoices[randomNewNoteIndex]
                        
                        if currentTempNoteNameWithOctave.contains("Bass") {
                            currentTempNoteNameWithOctave.removeLast(4)
                        }
                        
                        let currentOctave = currentTempNoteNameWithOctave.last!
                        
                        let currentTempNoteNameWithoutOctave = String(currentTempNoteNameWithOctave[currentTempNoteNameWithOctave.startIndex...currentTempNoteNameWithOctave.index(after: currentTempNoteNameWithOctave.startIndex)])
                       
                        var currentNoteToDisplay = getEnharmonic(currentNote: currentTempNoteNameWithoutOctave)!
                        
                        currentNoteToDisplay.append(currentOctave)
                        
                        print("MODE B, allAccidentalsEnabled, contains(#)... currentNoteToDisplay: \(currentNoteToDisplay)")
                        
                        currentCorrectAnswer = currentNoteChoices[randomNewNoteIndex]
                        
                        // display a flat (but correctAnswer is still a sharp!)
                        noteOnStaffImage.image = UIImage(named: "staff\(currentNoteToDisplay)")
                        
                    // sharp
                    } else {
                        currentCorrectAnswer = currentNoteChoices[randomNewNoteIndex]
                        noteOnStaffImage.image = UIImage(named: "staff\(currentCorrectAnswer)")
                    }
                
                // show regular note
                } else {
                    
                    currentCorrectAnswer = currentNoteChoices[randomNewNoteIndex]
                    noteOnStaffImage.image = UIImage(named: "staff\(currentCorrectAnswer)")
                }
                
            } else if onlySharpsEnabled {
                
                currentCorrectAnswer = currentNoteChoices[randomNewNoteIndex]
                noteOnStaffImage.image = UIImage(named: "staff\(currentCorrectAnswer)")
                
            } else if onlyFlatsEnabled {
                
                if currentNoteChoices[randomNewNoteIndex].contains("#") {
            
                    var currentTempNoteNameWithOctave = currentNoteChoices[randomNewNoteIndex]
                    
                    if currentTempNoteNameWithOctave.contains("Bass") {
                        currentTempNoteNameWithOctave.removeLast(4)
                    }
                    
                    let currentOctave = currentTempNoteNameWithOctave.last!
                    
                    let currentTempNoteNameWithoutOctave = String(currentTempNoteNameWithOctave[currentTempNoteNameWithOctave.startIndex...currentTempNoteNameWithOctave.index(after: currentTempNoteNameWithOctave.startIndex)])
                    
                    var currentNoteToDisplay = getEnharmonic(currentNote: currentTempNoteNameWithoutOctave)!
                    
                    currentNoteToDisplay.append(currentOctave)
                    
                    print("MODE B, allAccidentalsEnabled, contains(#)... currentNoteToDisplay: \(currentNoteToDisplay)")
                    
                    currentCorrectAnswer = currentNoteChoices[randomNewNoteIndex]
                    
                    // display a flat (but correctAnswer is still a sharp!)
                    noteOnStaffImage.image = UIImage(named: "staff\(currentNoteToDisplay)")
                    
                } else {
                    
                    currentCorrectAnswer = currentNoteChoices[randomNewNoteIndex]
                    noteOnStaffImage.image = UIImage(named: "staff\(currentCorrectAnswer)")
                    
                }
                
            } else {
                
                currentCorrectAnswer = currentNoteChoices[randomNewNoteIndex]
                noteOnStaffImage.image = UIImage(named: "staff\(currentCorrectAnswer)")
                
            }
            
            print("!!! currentCorrectAnswer should be: \(currentCorrectAnswer)!!!")
            
        }
        
    }
    
    func startNewRound() {

        lastRandomNumber = randomNewNoteIndex
        totalScore = 0
        scoreLabelOutlet.text = "0"
        correctAnswersInARow = 0
        incorrectAnswersInARow = 0
        currentNumberOfStars = 0
        starsImageOutlet.image = UIImage(named: "stars\(currentNumberOfStars)")

        generateNewNote()
        
    }
    
    // old way of scrolling thru the notes on staff
    
//    @IBAction func handleMainNotePanGesture(recognizer: UIPanGestureRecognizer) {
//
////        print(recognizer.velocity(in: self.view).y)
//
//        if recognizer.velocity(in: self.view).y < 0 && Int(locationTracker) < whiteNotesOnLargeKeyboard.count - 1 {
////            print("panning up!")
//            locationTracker += 0.17
//
//            if recognizer.velocity(in: self.view).y < -150 && Int(locationTracker) < whiteNotesOnLargeKeyboard.count - 1 {
//                locationTracker += 0.5
//            }
//
//        } else if recognizer.velocity(in: self.view).y > 0 && locationTracker > 0 {
//            locationTracker -= 0.17
////            print("panning down!")
//
//            if recognizer.velocity(in: self.view).y > 150 && locationTracker > 0 {
//                locationTracker -= 0.5
//            }
//        }
//
//    }
    
    @IBOutlet var noteRangeLowNotePanGestureOutlet: UIPanGestureRecognizer!
    
    @IBOutlet var noteRangeHighNotePanGestureOutlet: UIPanGestureRecognizer!
    
    var previousTempLowNoteIndex = 0
    
    @IBAction func handleLowNotePan(recognizer: UIPanGestureRecognizer) {
        
        if lowNoteIndex < 15 {
            onlyTrebleClefBlackNotesEnabled = false
            onlyTrebleClefSwitchOutlet.isOn = false
            onlyTrebleClefSegmentedControlOutlet.selectedSegmentIndex = 0
        }
        
       
        // only move the note if it's in a certain range
//        if lowNoteIndex >= 0  {
        
        print("low note moving")
        
        let newTempNoteIndex = whiteNotesOnLargeKeyboard.count - Int((Double(recognizer.location(in: noteRangeLowNoteImage).y) - noteRangeImageLocationAdjustment) / noteRangeLocationFactor)
        
        // going up
        if newTempNoteIndex > previousTempLowNoteIndex && lowNoteIndex < highNoteIndex - 1 {
            
            print("low note moving up")
            
            currentNoteChoices.removeFirst()

            updateNoteIndices()
            
        // going down
        } else if newTempNoteIndex < previousTempLowNoteIndex && lowNoteIndex > 0 {
            
            print("low note moving down")
            
            if allAccidentalsEnabled {
                let tempLowestNoteIndex = allNotesOnLargeKeyboardForVariousSettings.index(of: currentNoteChoices.first!)!
                currentNoteChoices.insert(allNotesOnLargeKeyboardForVariousSettings[tempLowestNoteIndex - 1], at: 0)
            } else {
                let tempLowestNoteIndex = whiteNotesOnLargeKeyboard.index(of: currentNoteChoices.first!)!
                currentNoteChoices.insert(whiteNotesOnLargeKeyboard[tempLowestNoteIndex - 1], at: 0)
            }
            
            updateNoteIndices()
            
        }
        
        noteRangeLowNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[lowNoteIndex])")
        
        previousTempLowNoteIndex = newTempNoteIndex
//        }
        
    }
    
    var previousTempHighNoteIndex = whiteNotesOnLargeKeyboard.count - 1
    
    @IBAction func handleHighNotePan(recognizer: UIPanGestureRecognizer) {
        
        if highNoteIndex > 14 {
            onlyBassClefBlackNotesEnabled = false
            onlyBassClefSwitchOutlet.isOn = false
            onlyBassClefSegmentedControlOutlet.selectedSegmentIndex = 0
        }
        
//        // only move the note if it's in a certain range
//        if highNoteIndex < whiteNotesOnLargeKeyboard.count - 1 && highNoteIndex > lowNoteIndex + 1 {
        
        print("high note moving")
        
        let newTempNoteIndex = whiteNotesOnLargeKeyboard.count - Int((Double(recognizer.location(in: noteRangeHighNoteImage).y) - noteRangeImageLocationAdjustment) / noteRangeLocationFactor)
        
        // going up
        if newTempNoteIndex > previousTempHighNoteIndex && highNoteIndex < whiteNotesOnLargeKeyboard.count - 1 {
            
            print("high note moving up")
            
            print("currentNoteChoices.last: \(currentNoteChoices.last)")
            
            if allAccidentalsEnabled || onlySharpsEnabled || onlyFlatsEnabled {
                let tempHighestNoteIndex = allNotesOnLargeKeyboardForVariousSettings.index(of: currentNoteChoices.last!)!
                currentNoteChoices.append(allNotesOnLargeKeyboardForVariousSettings[tempHighestNoteIndex + 1])
            } else {
                let tempHighestNoteIndex = whiteNotesOnLargeKeyboard.index(of: currentNoteChoices.last!)!
                currentNoteChoices.append(whiteNotesOnLargeKeyboard[tempHighestNoteIndex + 1])
            }
            
            updateNoteIndices()
            
            // going down
        } else if newTempNoteIndex < previousTempHighNoteIndex && highNoteIndex > lowNoteIndex + 1 {
            
            print("high note moving down")
            
            currentNoteChoices.removeLast()
            
            updateNoteIndices()
            
        }
        
        noteRangeHighNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[highNoteIndex])")
        
        previousTempHighNoteIndex = newTempNoteIndex
            
//        }
    }
    
    var noteIndex = 0
    
    @IBAction func handleNoteOnStaffPanning(recognizer: UIPanGestureRecognizer) {
        print(recognizer.location(in: noteOnStaffImage).y)
        
        noteIndex = whiteNotesOnLargeKeyboard.count - Int((Double(recognizer.location(in: noteOnStaffImage).y) - noteOnStaffImageLocationAdjustment) / noteOnStaffLocationFactor)
        
//        print("highNoteIndex in handleHighNotePan:\(highNoteIndex)")
        
        if noteIndex >= 0 && noteIndex < whiteNotesOnLargeKeyboard.count {
            noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[noteIndex])")
            currentNoteOnStaffIndex = noteIndex
            currentNoteOnStaffImageName = "staff\(whiteNotesOnLargeKeyboard[currentNoteOnStaffIndex])"
//            updateNoteOnStaffImage(optionalImageName: nil)
            currentAccidental = .neither
        }
    }
    
//    @IBAction func handleMenuLowNotePanGesture(_ sender: UIPanGestureRecognizer) {
//        print(sender.location(in: noteRangeLowNoteImage))
//    }
    
    
//    @IBAction func handleMenuHightNotePanGesture(_ sender: UIPanGestureRecognizer) {
//    }
    
    func updateLowAndHighNoteIndices() {
        
    }
    
    func updateNoteRangeImages() {
        noteRangeLowNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[lowNoteIndex])")
        noteRangeHighNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[highNoteIndex])")
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
    
    // function for adding subviews
    func addSameSize(subview: UIView, onTopOf superview: UIView) {
        superview.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        subview.widthAnchor.constraint(equalTo: superview.widthAnchor).isActive = true
        subview.heightAnchor.constraint(equalTo: superview.heightAnchor).isActive = true
        
        subview.contentMode = superview.contentMode
    }
    
    func switchModes() {
        switch currentGameMode {
        case .A:
            print("switching to mode B")
            setupForModeB()
        case .B:
            print("switching to mode A")
            setupForModeA()
        }
        
        startNewRound()
    }
    
    func setupForModeA() {
        currentGameMode = .A
        
        // show mode A controls
        accidentalsButtonsOutlet.alpha = 1
        arrowAndCheckButtonsOutlet.alpha = 1
        
        allKeyButtons.isUserInteractionEnabled = false
        noteOnStaffImage.isUserInteractionEnabled = true
        
        //            includeEnharmonicsSwitchOutlet.isEnabled = false
        topLabelOutlet.image = UIImage(named: "choose_the_correct_note_on_staff")
        topLabelOutlet.transform = CGAffineTransform(scaleX: CGFloat(labelScaleMultiplierBackToNormalNotesOnStaff ), y: CGFloat(labelScaleMultiplierBackToNormalNotesOnStaff))
        
        accidentalsSegmentedControlOutlet.selectedSegmentIndex = 0
        accidentalsSegmentedControlOutlet.isEnabled = false
    }
    
    func setupForModeB() {
        currentGameMode = .B
        
        // hide mode A controls
        accidentalsButtonsOutlet.alpha = 0
        arrowAndCheckButtonsOutlet.alpha = 0
        
        allKeyButtons.isUserInteractionEnabled = true
        noteOnStaffImage.isUserInteractionEnabled = false
        
        //            includeEnharmonicsSwitchOutlet.isEnabled = true
        topLabelOutlet.image = UIImage(named: "tap_the_correct_key")
        topLabelOutlet.transform = CGAffineTransform(scaleX: CGFloat(labelScaleMultiplierNotesOnStaff), y: CGFloat(labelScaleMultiplierNotesOnStaff))
        
        accidentalsSegmentedControlOutlet.isEnabled = true
    }
    
}
