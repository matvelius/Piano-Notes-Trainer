//
//  ViewController.swift
//  Piano Notes
//
//  Created by Matvey on 1/29/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var correctNote = ""
    var answer: Bool = false
    
    // note button outlets
    @IBOutlet weak var noteButtonA: UIButton!
    @IBOutlet weak var noteButtonB: UIButton!
    @IBOutlet weak var noteButtonC: UIButton!
    @IBOutlet weak var noteButtonD: UIButton!
    @IBOutlet weak var noteButtonE: UIButton!
    @IBOutlet weak var noteButtonF: UIButton!
    @IBOutlet weak var noteButtonG: UIButton!
    
    // piano image outlet
    @IBOutlet weak var pianoImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        generateNote()
    }
    
    func generateNote() {
        let targetValue = Int.random(in: 0...6)
        let highlightedNoteChoice = ["C4", "D4", "E4", "F4", "G4", "A5", "B5"]
        correctNote = highlightedNoteChoice[targetValue]
        pianoImage.image = UIImage(named: highlightedNoteChoice[targetValue])
    }
    
    func checkNote(userNoteChoice: String) {
        var imageName = ""
        // print(userNoteChoice)
        switch userNoteChoice {
            
        case "A5":
            userNoteChoice == correctNote ? (imageName = "A_right") : (imageName = "A_wrong")
            let image = UIImage(named: imageName)
            noteButtonA.setImage(image, for: UIControl.State.normal)
            
        case "B5":
            userNoteChoice == correctNote ? (imageName = "B_right") : (imageName = "B_wrong")
            let image = UIImage(named: imageName)
            noteButtonB.setImage(image, for: UIControl.State.normal)
            
        case "C4":
            userNoteChoice == correctNote ? (imageName = "C_right") : (imageName = "C_wrong")
            let image = UIImage(named: imageName)
            noteButtonC.setImage(image, for: UIControl.State.normal)
            
        case "D4":
            userNoteChoice == correctNote ? (imageName = "D_right") : (imageName = "D_wrong")
            let image = UIImage(named: imageName)
            noteButtonD.setImage(image, for: UIControl.State.normal)
            
        case "E4":
            userNoteChoice == correctNote ? (imageName = "E_right") : (imageName = "E_wrong")
            let image = UIImage(named: imageName)
            noteButtonE.setImage(image, for: UIControl.State.normal)
            
        case "F4":
            userNoteChoice == correctNote ? (imageName = "F_right") : (imageName = "F_wrong")
            let image = UIImage(named: imageName)
            noteButtonF.setImage(image, for: UIControl.State.normal)
            
        case "G4":
            userNoteChoice == correctNote ? (imageName = "G_right") : (imageName = "G_wrong")
            let image = UIImage(named: imageName)
            noteButtonG.setImage(image, for: UIControl.State.normal)
            
        default:
            print("default case")
        }
        
        // wait 1 sec, then reset the buttons
        // MAYBE USE SLEEP INSTEAD? so that the user can't press anything for a sec
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            
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
            
            // pick new note
            self.generateNote()
            
        })
        
        
    }
    
    @IBAction func noteA(_ sender: UIButton) {
        checkNote(userNoteChoice: "A5")
    }
    
    @IBAction func noteB(_ sender: UIButton) {
        checkNote(userNoteChoice: "B5")
    }

    @IBAction func noteC(_ sender: UIButton) {
        checkNote(userNoteChoice: "C4")
    }
    
    @IBAction func noteD(_ sender: UIButton) {
        checkNote(userNoteChoice: "D4")
    }
    
    @IBAction func noteE(_ sender: UIButton) {
        checkNote(userNoteChoice: "E4")
    }
    
    @IBAction func noteF(_ sender: UIButton) {
        checkNote(userNoteChoice: "F4")
    }
    
    @IBAction func noteG(_ sender: UIButton) {
        checkNote(userNoteChoice: "G4")
    }

}

