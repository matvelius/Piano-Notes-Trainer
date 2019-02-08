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

class ViewController: UIViewController {
    
    // instance variable to hold the AVAudioPlayer object
    var audioPlayer: AVAudioPlayer?
    
    // placeholder variables for comparing answers
    var currentCorrectAnswer = ""
    var currentUserAnswer = ""
    
    // placeholder for current note
    var currentNote = ""
    
    // note button outlets
    @IBOutlet weak var noteButtonA: UIButton!
    @IBOutlet weak var noteButtonB: UIButton!
    @IBOutlet weak var noteButtonC: UIButton!
    @IBOutlet weak var noteButtonD: UIButton!
    @IBOutlet weak var noteButtonE: UIButton!
    @IBOutlet weak var noteButtonF: UIButton!
    @IBOutlet weak var noteButtonG: UIButton!
    
    // placeholder variable for the button user presses
    var currentNoteButton: UIButton!
    
    // piano image outlet
    @IBOutlet weak var pianoImage: UIImageView!
    
    // placeholder variable for last-selected random number
    var lastRandomNumber: Int = -1
    var randomNewNoteIndex = Int.random(in: 0...6)
    
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
        startNewRound()
    }
    
    func startNewRound() {
        lastRandomNumber = randomNewNoteIndex
        totalScore = 0
        generateNewNote()
    }
    
    func generateNewNote() {
        
        randomNewNoteIndex = Int.random(in: 0...6)
        
        while randomNewNoteIndex == lastRandomNumber {
            randomNewNoteIndex = Int.random(in: 0...6)
//            print("generateNewNote() called; randomNewNoteIndex = \(randomNewNoteIndex)")
        }
        
        let highlightedNoteChoice = ["C4", "D4", "E4", "F4", "G4", "A4", "B4"]
        currentNote = highlightedNoteChoice[randomNewNoteIndex]
        currentCorrectAnswer = String(currentNote[currentNote.startIndex])
        pianoImage.image = UIImage(named: currentNote)
        
        lastRandomNumber = randomNewNoteIndex
        
    }
    
    func checkAnswer() {
        
        // placeholder variable for button image name
        var imageName = ""
        
        // right answer
        if currentUserAnswer == currentCorrectAnswer {
            
            // play sound
            loadSound()
            audioPlayer!.play()
            
            // show result (green button)
            imageName = "\(currentCorrectAnswer)_right"
            let image = UIImage(named: imageName)
            currentNoteButton.setImage(image, for: UIControl.State.normal)
            
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
            
            // color button red
            imageName = "\(currentUserAnswer)_wrong"
            let image = UIImage(named: imageName)
            currentNoteButton.setImage(image, for: UIControl.State.normal)
            
            if totalScore > 0 {
                totalScore -= 1
            }
            
            // flash score label red FF3939
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
    
    func loadSound() {
        // sound file
        let sound = Bundle.main.path(forResource: "\(currentNote)", ofType: "aiff")!
        
        //print(String(sound))
        
        do {
            // try to initialize with the URL created above
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func noteA(_ sender: UIButton) {
        currentUserAnswer = "A"
        currentNoteButton = noteButtonA
        checkAnswer()
    }
    
    @IBAction func noteB(_ sender: UIButton) {
        currentUserAnswer = "B"
        currentNoteButton = noteButtonB
        checkAnswer()
    }

    @IBAction func noteC(_ sender: UIButton) {
        currentUserAnswer = "C"
        currentNoteButton = noteButtonC
        checkAnswer()
    }
    
    @IBAction func noteD(_ sender: UIButton) {
        currentUserAnswer = "D"
        currentNoteButton = noteButtonD
        checkAnswer()
    }
    
    @IBAction func noteE(_ sender: UIButton) {
        currentUserAnswer = "E"
        currentNoteButton = noteButtonE
        checkAnswer()
    }
    
    @IBAction func noteF(_ sender: UIButton) {
        currentUserAnswer = "F"
        currentNoteButton = noteButtonF
        checkAnswer()
    }
    
    @IBAction func noteG(_ sender: UIButton) {
        currentUserAnswer = "G"
        currentNoteButton = noteButtonG
        checkAnswer()
    }

}

