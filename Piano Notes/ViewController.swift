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
    
    
    // keeping track of the accidentals
    enum Accidentals {
        case sharp
        case flat
        case neither
    }
    
    var currentAccidental: Accidentals = .neither
    
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
    
//    var openMenuCenterPoint = CGPoint(x: 0, y: 0)
//    var currentMenuCenterPointY: CGFloat = 0.0
//    var closedMenuCenterPoint = CGPoint(x: -100, y: 0)
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        
        // figure out how to slide the menu out
        
        if menuIsClosed {
            
            self.menuLeadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                
                self.view.layoutIfNeeded()
                self.darkOverlayOutlet.alpha = 0.73
                self.menuBackgroundOutlet.alpha = 1
                self.menuLeadingConstraint.constant = 0
                
            })
        
//            UIView.animate(withDuration: 3.5) {
//
////                self.menuBackgroundOutlet.center = CGPoint(x: 200, y: self.currentMenuCenterPointY)
////                self.menuBackgroundOutlet.leadingAnchor = self.
////                self.menuBackgroundOutlet.leadingAnchor = self.menuBackgroundOutlet.superview?.leadingAnchor
//            }
            
            menuButtonOutlet.setTitle("✕", for: .normal)
            
            menuIsClosed = false
            
        } else {
            
//            closedMenuCenterPoint = CGPoint(x: -100, y: 0)
            
            self.menuLeadingConstraint.constant = -460
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            
                self.view.layoutIfNeeded()
                self.darkOverlayOutlet.alpha = 0
                self.menuBackgroundOutlet.alpha = 0
            
            })
            
//            UIView.animate(withDuration: 3.5) {
//
//
////                self.menuBackgroundOutlet.center = CGPoint(x: 400, y: self.currentMenuCenterPointY)
//            }
            
            menuButtonOutlet.setTitle("☰", for: .normal)
            
            menuIsClosed = true
            
        }
        
    }
    
    @IBAction func onlyWhiteKeysSwitch(_ sender: UISwitch) {
        
        // disable sharps and flats, make them invisible, disable gesture recognizers
        if sender.isOn == true {
            
            currentNoteChoices = onlyWhiteKeyChoices
            randomNewNoteIndexUpperLimit = onlyWhiteKeyChoices.count - 1
        
            for sharp in sharpsOutletCollection {
                sharp.isEnabled = false
            }
            
            for flat in flatsOutletCollection {
                flat.isEnabled = false
            }
            
            sharpsViewOutlet.alpha = 0
            flatsViewOutlet.alpha = 0
            
            for panGestureRecognizer in panGestureRecognizersCollection {
                panGestureRecognizer.isEnabled = false
            }
            
            startNewRound()
        
        // otherwise reenable everything
        } else {
            
            currentNoteChoices = allNoteChoices
            randomNewNoteIndexUpperLimit = allNoteChoices.count - 1
            
            for sharp in sharpsOutletCollection {
                sharp.isEnabled = true
            }
            
            for flat in flatsOutletCollection {
                flat.isEnabled = true
            }
            
            sharpsViewOutlet.alpha = 1
            flatsViewOutlet.alpha = 1
            
            for panGestureRecognizer in panGestureRecognizersCollection {
                panGestureRecognizer.isEnabled = true
            }
            
            startNewRound()
            
        }
            
    }
    
    // enable / disable based on the white keys switch
    @IBAction func whiteKeySettingsSegmentedControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            // all white keys
            currentNoteChoices = onlyWhiteKeyChoices
            randomNewNoteIndexUpperLimit = onlyWhiteKeyChoices.count - 1
            
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
            currentNoteChoices = onlyCDE
            randomNewNoteIndexUpperLimit = onlyCDE.count - 1
            
            disableButtons()
            
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
            currentNoteChoices = onlyFGAB
            randomNewNoteIndexUpperLimit = onlyFGAB.count - 1
            
            disableButtons()
            
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
    
    
    @IBAction func includeEnharmonicsSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func onlyBlackKeysSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func blackKeySettingsSegmentedControl(_ sender: UISegmentedControl) {
    }
    
    var soundsEnabled = true
    
    @IBAction func enableSoundsSwitch(_ sender: UISwitch) {
        
        if sender.isOn == false {
            
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
    
    // piano image outlet
    @IBOutlet weak var pianoImage: UIImageView!
    
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
    
    var currentNoteChoices = [""]
    
    let allNoteChoices = ["F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", "C5", "C#5",  "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5"]
    
    let onlyWhiteKeyChoices = ["G3", "A3", "B3", "C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5", "G5", "A5"]
    
    let onlyCDE = ["C4", "D4", "E4", "C5", "D5", "E5"]
    
    let onlyFGAB = ["G3", "A3", "B3", "F4", "G4", "A4", "B4", "F5", "G5", "A5"]
    
    var randomNewNoteIndexUpperLimit = 0
    
    // placeholder variable for last-selected random number
    var lastRandomNumber: Int = -1
    var randomNewNoteIndex = Int.random(in: 0...15)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        currentNoteChoices = onlyWhiteKeyChoices
        randomNewNoteIndexUpperLimit = onlyWhiteKeyChoices.count - 1
//        print("onlyWhiteKeyChoices.count: \(onlyWhiteKeyChoices.count)")
        
        // disable sharps and flats, make them invisible, disable gesture recognizers
        for sharp in sharpsOutletCollection {
            sharp.isEnabled = false
        }
        
        for flat in flatsOutletCollection {
            flat.isEnabled = false
        }
        
        sharpsViewOutlet.alpha = 0
        flatsViewOutlet.alpha = 0
        
        for panGestureRecognizer in panGestureRecognizersCollection {
            panGestureRecognizer.isEnabled = false
        }
        
        
        // calculate shaprs & flats bounds for pan gesture recognition
        sharpsUpperBound = sharpsViewOutlet.bounds.maxY + 5
        sharpsLowerBound = sharpsViewOutlet.bounds.minY - 10
        
        flatsUpperBound = flatsViewOutlet.bounds.maxY + 10
        flatsLowerBound = flatsViewOutlet.bounds.minY - 5
        
        // calculate note button bounds for pan gesture recognition
        noteButtonUpperBoundY = noteButtonD.bounds.maxY
        noteButtonLowerBoundY = noteButtonD.bounds.minY
    
        
//        accidentalsBottomEdgeYCoordinate = sharpsOutletCollection.first!.bounds.maxY
//        print("accidentalsBottomEdgeYCoordinate: \(accidentalsBottomEdgeYCoordinate)")
//        let boundsOfSharps = sharpsOutletCollection.first?.bounds
//        let bottomOfSharps =
        
        
//        print("first sharp bounds minY: \(sharpsOutletCollection.first?.bounds.minY)")
//        print("first sharp bounds maxY: \(sharpsOutletCollection.first?.bounds.maxY)")
//
//        print("UIApplication shared keyWindow bounds minY: \(UIApplication.shared.keyWindow?.bounds.minY)")
//
//        print("UIApplication shared keyWindow bounds maxY: \(UIApplication.shared.keyWindow?.bounds.maxY)")
        
        menuBackgroundOutlet.alpha = 0
        
        menuLeadingConstraint.constant = -460
        
//        openMenuCenterPoint = menuBackgroundOutlet.center
//        currentMenuCenterPointY = menuBackgroundOutlet.center.y
        
        scoreLabel.text = "0"
        
        startNewRound()
//        print("noteButtonA's coordinateSpace is: ")
//        print(noteButtonA.coordinateSpace)
//
//        print(UIApplication.shared.keyWindow?.coordinateSpace)
    }
    
    func startNewRound() {
        
        lastRandomNumber = randomNewNoteIndex
        totalScore = 0
        scoreLabel.text = "0"
        correctAnswersInARow = 0
        incorrectAnswersInARow = 0
        currentNumberOfStars = 0
        stars.image = UIImage(named: "stars\(currentNumberOfStars)")

        generateNewNote()
        
    }
    
    func generateNewNote() {
        
        randomNewNoteIndex = Int.random(in: 0...randomNewNoteIndexUpperLimit)
        
        while randomNewNoteIndex == lastRandomNumber {
            randomNewNoteIndex = Int.random(in: 0...randomNewNoteIndexUpperLimit)
//            print("generateNewNote() called; randomNewNoteIndex = \(randomNewNoteIndex)")
        }
        
//        print("NUMBER OF NOTES: \(highlightedNoteChoice.count)")
        currentNote = currentNoteChoices[randomNewNoteIndex]
        print("the current note is \(currentNote)")
        
        let currentNoteNameLength = currentNote.count
        
        if currentNoteNameLength == 3 {
            currentCorrectAnswer = String(currentNote[currentNote.startIndex...currentNote.index(after: currentNote.startIndex)])
            print("currentCorrectAnswer when name length == 3: \(currentCorrectAnswer)")
        } else {
            currentCorrectAnswer = String(currentNote[currentNote.startIndex])
            print("currentCorrectAnswer when name length == \(currentNoteNameLength): \(currentCorrectAnswer)")
        }
//        currentCorrectAnswer = String(currentNote[currentNote.startIndex])
        print("currentCorrectAnswer is \(currentCorrectAnswer)")
        pianoImage.image = UIImage(named: currentNote)
        
        lastRandomNumber = randomNewNoteIndex
        
    }
    
    func checkAnswer() {
        
        // placeholder variable for button image name
        var imageName = ""
        
        // get enharmonic equivalent
        let currentEnharmonic: String? = getEnharmonic(currentNote: currentUserAnswer)
        
        // right answer
        if currentUserAnswer == currentCorrectAnswer || currentEnharmonic == currentCorrectAnswer {
//            print("CORRECT!!!")
//
//            print("in checkAnswer, currentCorrectAnswer is: \(currentCorrectAnswer)")
//            print("in checkAnswer, currentUserAnswer is: \(currentUserAnswer)")
//            print("in checkAnswer, currentEnharmonic is: \(currentEnharmonic)")
            
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
            
            // user answers Cb, correct answer is B
        
            if currentEnharmonic == currentCorrectAnswer {
                
                // change the correct note buttons' colors
                imageName = "\(currentUserAnswer[currentUserAnswer.startIndex])_right"
                
            } else {
        
                imageName = "\(currentCorrectAnswer[currentCorrectAnswer.startIndex])_right"

            }
            
            print("imageName = \(imageName)")
            //            print("currentButton.tag = \(currentNoteButton.tag)")
            let image = UIImage(named: imageName)
            currentNoteButton.setImage(image, for: UIControl.State.normal)
            
            // play sound
            if soundsEnabled {
                loadSound(currentSound: currentNote)
                audioPlayer!.play()
                audioPlayer!.setVolume(0, fadeDuration: 2.5)
            }
            //            print(currentNote)
            //            play(sound: "\(currentNote)", ofType: .wav)
            disableButtons()
            
            // update score
            totalScore += 1
            correctAnswersInARow += 1
            incorrectAnswersInARow = 0
            giveOrTakeAStar()
            
            //            usleep(1000000) //will sleep for 1 second
            //            Thread.sleep(forTimeInterval: 60/cadence)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
                self.resetButtonsToDefault()
                self.generateNewNote()
                self.enableButtons()
            })
            
        // wrong answer
        } else {
            
            // show result (red button)
            // if dealing with sharp or flat, light up regular letter + #/b symbol
            if currentUserAnswer.count == 2 {
                
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
            // color button red
            imageName = "\(currentUserAnswer[currentUserAnswer.startIndex])_wrong"
//            imageName = "\(currentUserAnswer.startIndex)_wrong"
            print("imageName is \(imageName)")
            let image = UIImage(named: imageName)
            currentNoteButton.setImage(image, for: UIControl.State.normal)
            
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
        noteButtonA.isEnabled = true;
        noteButtonB.isEnabled = true;
        noteButtonC.isEnabled = true;
        noteButtonD.isEnabled = true;
        noteButtonE.isEnabled = true;
        noteButtonF.isEnabled = true;
        noteButtonG.isEnabled = true;
    }
    
    func loadSound(currentSound: String) {
        // sound file
        if let sound = Bundle.main.path(forResource: currentSound, ofType: "aiff") {

            //print(String(sound))

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
        
//        print("recognizer.location(in: self.view).y: \(recognizer.location(in: self.view).y)")
//
//        print("sharpsViewOutlet.bounds: \(sharpsViewOutlet.bounds)")
//        print("<-- current Y location")
        
//        let sharpView = sharpsOutletCollection.first
//        let appWindowView = UIApplication.shared.keyWindow
//        let convertedCoordinatesOfRecognizer = sharpsViewOutlet.convert(recognizer.location(in: self.view), to: sharpsViewOutlet)
//
//        let convertedCoordinatesOfSharp = sharpsViewOutlet.convert(sharpsOutletCollection.first!.bounds, to: sharpsViewOutlet)
        
//        print("convertedCoordinatesOfRecognizer: \(convertedCoordinatesOfRecognizer)")
//        print("convertedCoordinatesOfSharp: \(convertedCoordinatesOfSharp)")
        
        
        
        let currentYCoordinateOfPanInRespectToSharps = recognizer.location(in: sharpsOutletCollection.first).y
        
        let currentYCoordinateOfPanInRespectToFlats = recognizer.location(in: flatsOutletCollection.first).y
        
        let currentYCoordinateOfPanInRespectToNoteButtons = recognizer.location(in: currentNoteButton).y
        
        let currentXCoordinateOfPanInRespectToCurrentNoteButton = recognizer.location(in: currentNoteButton).x
        
//        print("currentYCoordinateOfPanInRespectToCurrentNoteButton: \(currentYCoordinateOfPanInRespectToNoteButtons)")
        
    
        
//        print("current Y location in respect to sharp: \(currentYCoordinateOfPanInRespectToSharps)")
//
//        print("sharpsViewOutlet.bounds.maxY: \(sharpsViewOutlet.bounds.maxY)")
//
//        print("current Y location in respect to flats: \(currentYCoordinateOfPanInRespectToFlats)")
        
        
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
                if sharp.tag == currentNoteButton.tag {
                    sharp.setImage(UIImage(named: "sharp"), for: .normal)
                }
            }

            for flat in flatsOutletCollection {
                if flat.tag == currentNoteButton.tag {
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
//                    print("ended! currentUserAnswer is: \(currentUserAnswer)")
                    return true
                    
                case .sharp:
                    currentAccidental = .sharp
                    currentUserAnswer = "\(currentUserAnswer)#"
                    let image = UIImage(named: "\(currentUserAnswer)_default")
                    currentNoteButton.setImage(image, for: UIControl.State.normal)
//                    print("ended! currentUserAnswer is: \(currentUserAnswer)")
                    return true
                    
                case .neither:
                    
                    currentAccidental = .neither
                    let image = UIImage(named: "\(currentUserAnswer)_default")
//                    print("CASE .neither, currentUserAnswer: \(currentUserAnswer)")
                    currentNoteButton.setImage(image, for: UIControl.State.normal)
                    
//                    self.note
                    return true
                    
//                default:
//                    print("something went weird...")
//                    break
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
    
}
