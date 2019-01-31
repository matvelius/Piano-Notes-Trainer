//
//  ViewController.swift
//  Piano Notes
//
//  Created by Matvey on 1/29/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // placeholder variables for comparing answers
    var currentCorrectAnswer = ""
    var currentUserAnswer = ""
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }
    
    func startNewRound() {
        lastRandomNumber = randomNewNoteIndex
        print("at the beginning, lastRandomNumber = \(lastRandomNumber)")
        generateNewNote()
    }
    
    func generateNewNote() {
        
        randomNewNoteIndex = Int.random(in: 0...6)
        
        while randomNewNoteIndex == lastRandomNumber {
            randomNewNoteIndex = Int.random(in: 0...6)
            print("generateNewNote() called; randomNewNoteIndex = \(randomNewNoteIndex)")
        }
        
        print("checkpoint 1! (inside generateNewNote)")
        
        let highlightedNoteChoice = ["C4", "D4", "E4", "F4", "G4", "A5", "B5"]
        let currentNote: String = highlightedNoteChoice[randomNewNoteIndex]
        currentCorrectAnswer = String(currentNote[currentNote.startIndex])
        pianoImage.image = UIImage(named: currentNote)
        
        lastRandomNumber = randomNewNoteIndex
        
        print("checkpoint 2! (inside generateNewNote)")
        
    }
    
    func checkAnswer() {
        
        print("check answer called!")
        
        // placeholder variable for button image name
        var imageName = ""
        
        if currentUserAnswer == currentCorrectAnswer {
            
            // show result (green button)
            imageName = "\(currentCorrectAnswer)_right"
            let image = UIImage(named: imageName)
            currentNoteButton.setImage(image, for: UIControl.State.normal)
            disableButtons()
            
//            usleep(1000000) //will sleep for 1 second
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:{
                self.resetButtonsToDefault()
                self.generateNewNote()
                self.enableButtons()
            })
            
            
        } else {
            
            // color button red
            imageName = "\(currentUserAnswer)_wrong"
            let image = UIImage(named: imageName)
            currentNoteButton.setImage(image, for: UIControl.State.normal)
            
        }
    }
    
    func resetButtonsToDefault() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {

        
        
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

//        })
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
    
//    func checkAnswer() {
//        var imageName = ""
//
//        switch currentUserAnswer {
//
//        case "A":
//            currentUserAnswer == currentCorrectAnswer ? (imageName = "A_right") : (imageName = "A_wrong")
//            let image = UIImage(named: imageName)
//            noteButtonA.setImage(image, for: UIControl.State.normal)
//
//        case "B":
//            currentUserAnswer == currentCorrectAnswer ? (imageName = "B_right") : (imageName = "B_wrong")
//            let image = UIImage(named: imageName)
//            noteButtonB.setImage(image, for: UIControl.State.normal)
//
//        case "C":
//            currentUserAnswer == currentCorrectAnswer ? (imageName = "C_right") : (imageName = "C_wrong")
//            let image = UIImage(named: imageName)
//            noteButtonC.setImage(image, for: UIControl.State.normal)
//
//        case "D":
//            currentUserAnswer == currentCorrectAnswer ? (imageName = "D_right") : (imageName = "D_wrong")
//            let image = UIImage(named: imageName)
//            noteButtonD.setImage(image, for: UIControl.State.normal)
//
//        case "E":
//            currentUserAnswer == currentCorrectAnswer ? (imageName = "E_right") : (imageName = "E_wrong")
//            let image = UIImage(named: imageName)
//            noteButtonE.setImage(image, for: UIControl.State.normal)
//
//        case "F":
//            currentUserAnswer == currentCorrectAnswer ? (imageName = "F_right") : (imageName = "F_wrong")
//            let image = UIImage(named: imageName)
//            noteButtonF.setImage(image, for: UIControl.State.normal)
//
//        case "G":
//            currentUserAnswer == currentCorrectAnswer ? (imageName = "G_right") : (imageName = "G_wrong")
//            let image = UIImage(named: imageName)
//            noteButtonG.setImage(image, for: UIControl.State.normal)
//
//        default:
//            print("default case")
//        }
//
//        // wait 1 sec, then reset the buttons
//        // MAYBE USE SLEEP INSTEAD? so that the user can't press anything for a sec
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//
//            var image = UIImage(named: "C_default")
//            self.noteButtonC.setImage(image, for: UIControl.State.normal)
//
//            image = UIImage(named: "D_default")
//            self.noteButtonD.setImage(image, for: UIControl.State.normal)
//
//            image = UIImage(named: "E_default")
//            self.noteButtonE.setImage(image, for: UIControl.State.normal)
//
//            image = UIImage(named: "F_default")
//            self.noteButtonF.setImage(image, for: UIControl.State.normal)
//
//            image = UIImage(named: "G_default")
//            self.noteButtonG.setImage(image, for: UIControl.State.normal)
//
//            image = UIImage(named: "A_default")
//            self.noteButtonA.setImage(image, for: UIControl.State.normal)
//
//            image = UIImage(named: "B_default")
//            self.noteButtonB.setImage(image, for: UIControl.State.normal)
//
//            // pick new note
//            self.generateNewNote()
//
//        })
//
//    }
    
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

