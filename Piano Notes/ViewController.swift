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
    }
    
    var currentAccidental: Accidentals = .flat
    
    var menuIsClosed: Bool = true
    
    
//    var notificationSoundLookupTable = [String: SystemSoundID]()
    
//    enum SoundExtension : String {
////        case caf
////        case aiff
//        case wav
//    }
    @IBOutlet weak var menuButtonOutlet: UIButton!
    
    @IBOutlet weak var darkOverlayOutlet: UIButton!
    
    @IBAction func darkOverlayPressed(_ sender: UIButton) {
    }
    
    @IBOutlet weak var menuBackgroundOutlet: UIView!
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        
        if menuIsClosed {
        
            darkOverlayOutlet.alpha = 0.73
            menuBackgroundOutlet.alpha = 1
            menuButtonOutlet.setTitle("✕", for: .normal)
            
            menuIsClosed = false
            
        } else {
            
            darkOverlayOutlet.alpha = 0
            menuBackgroundOutlet.alpha = 0
            menuButtonOutlet.setTitle("☰", for: .normal)
            
            menuIsClosed = true
            
        }
        
    }
    
    
    // note button outlets
    @IBOutlet weak var noteButtonA: UIButton!
    @IBOutlet weak var noteButtonB: UIButton!
    @IBOutlet weak var noteButtonC: UIButton!
    @IBOutlet weak var noteButtonD: UIButton!
    @IBOutlet weak var noteButtonE: UIButton!
    @IBOutlet weak var noteButtonF: UIButton!
    @IBOutlet weak var noteButtonG: UIButton!
    
    @IBOutlet var sharpsOutletCollection: [UIButton]!
    
    
    @IBOutlet var flatsOutletCollection: [UIButton]!
    
    
    // placeholder variable for the button user presses
    var currentNoteButton: UIButton!
    
    // piano image outlet
    @IBOutlet weak var pianoImage: UIImageView!
    
    // placeholder variable for last-selected random number
    var lastRandomNumber: Int = -1
    var randomNewNoteIndex = Int.random(in: 0...15)
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBackgroundOutlet.alpha = 0
        
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
//        disposeSoundIDs()
        generateNewNote()
        
    }
    
    func generateNewNote() {
        
        randomNewNoteIndex = Int.random(in: 0...28)
        
        while randomNewNoteIndex == lastRandomNumber {
            randomNewNoteIndex = Int.random(in: 0...28)
//            print("generateNewNote() called; randomNewNoteIndex = \(randomNewNoteIndex)")
        }
        
//        let highlightedNoteChoice = ["G3", "A3", "B3", "C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5", "G5", "A5"]
        
        let highlightedNoteChoice = ["F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", "C5", "C#5",  "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5"]
//        print("NUMBER OF NOTES: \(highlightedNoteChoice.count)")
        currentNote = highlightedNoteChoice[randomNewNoteIndex]
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
            print("CORRECT!!!")
            
            print("in checkAnswer, currentCorrectAnswer is: \(currentCorrectAnswer)")
            print("in checkAnswer, currentUserAnswer is: \(currentUserAnswer)")
            print("in checkAnswer, currentEnharmonic is: \(currentEnharmonic)")
            
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
            loadSound(currentSound: currentNote)
            audioPlayer!.play()
            audioPlayer!.setVolume(0, fadeDuration: 2.5)
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
                }
                
            }
            
            // play "wrong" sound
            loadSound(currentSound: "wrong")
            audioPlayer!.play()
            audioPlayer!.setVolume(0.06, fadeDuration: 0)
            
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
        
        // is there a way to loop thru these?
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
        print(recognizer.location(in: self.view).y)
        print("<-- current Y location")
        
        var panGestureOver: Bool = false
        
        func checkIfStateEnded(onSharpOrFlat: Accidentals) -> Bool {
            
            if recognizer.state == .ended {
                switch onSharpOrFlat {
                case .flat:
                    currentAccidental = .flat
                    currentUserAnswer = "\(currentUserAnswer)b"
                    let image = UIImage(named: "\(currentUserAnswer)_default")
                    currentNoteButton.setImage(image, for: UIControl.State.normal)
                    print("ended! currentUserAnswer is: \(currentUserAnswer)")
                    return true
                case .sharp:
                    currentAccidental = .sharp
                    currentUserAnswer = "\(currentUserAnswer)#"
                    let image = UIImage(named: "\(currentUserAnswer)_default")
                    currentNoteButton.setImage(image, for: UIControl.State.normal)
                    print("ended! currentUserAnswer is: \(currentUserAnswer)")
                    return true
                default:
                    print("something went weird...")
                    break
                }
            }
            
            return false
            
        }
        
        let image = UIImage(named: "\(currentUserAnswer)_pressed")
//        print("currentUserAnswer is: \(currentUserAnswer)")
        currentNoteButton.setImage(image, for: UIControl.State.normal)
        
        let currentLocationY = recognizer.location(in: self.view).y
        
        
        
        // recognize flat
        if currentLocationY > 295 && currentLocationY < 360 {
            
//            print("flat! \(currentLocationY)")
            
            panGestureOver = checkIfStateEnded(onSharpOrFlat: .flat)
            
            if panGestureOver {
//                currentUserAnswer = "\(currentUserAnswer)b"
//                print(currentUserAnswer)
                
                checkAnswer()
            }
            
        // recognize sharp
        } else if currentLocationY < 188 && currentLocationY > 0 {
            
//            print("sharp! \(currentLocationY)")
            panGestureOver = checkIfStateEnded(onSharpOrFlat: .sharp)
            
            if panGestureOver {
//                currentUserAnswer = "\(currentUserAnswer)#"
//                print(currentUserAnswer)
                
                checkAnswer()
            }
            
        }
        
    }
    
    //  figure out which button is sending the translation message
    //  get coordinates of the triangle button (as a variable -- changes with size right?)
    //  make sure buttons look correct depending on user action
    //  disable red button
    
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
    }
    
    @IBAction func touchDownB(_ sender: UIButton) {
        currentUserAnswer = "B"
        currentNoteButton = noteButtonB
    }
    
    @IBAction func touchDownC(_ sender: UIButton) {
        currentUserAnswer = "C"
        currentNoteButton = noteButtonC
    }
    
    
    @IBAction func touchDownD(_ sender: UIButton) {
        currentUserAnswer = "D"
        currentNoteButton = noteButtonD
    }
    
    @IBAction func touchDownE(_ sender: UIButton) {
        currentUserAnswer = "E"
        currentNoteButton = noteButtonE
    }
    
    @IBAction func touchDownF(_ sender: UIButton) {
        currentUserAnswer = "F"
        currentNoteButton = noteButtonF
    }
    
    
    @IBAction func touchDownG(_ sender: UIButton) {
        currentUserAnswer = "G"
        currentNoteButton = noteButtonG
    }
    
    
}

