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
    
    @IBOutlet var panGestureRecognizerOutlet: UIPanGestureRecognizer!
    
    
    @IBAction func sharpButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func naturalButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func flatButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func upArrowButtonPressed(_ sender: UIButton) {
        if currentNoteIndex < whiteNotesOnLargeKeyboard.count - 1 {
            currentNoteIndex += 1
            updateNoteOnStaffImage()
        }
    }
    
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func downArrowButtonPressed(_ sender: UIButton) {
        if currentNoteIndex > 0 {
            currentNoteIndex -= 1
            updateNoteOnStaffImage()
        }
    }
    
    
    
    
    var currentNoteIndex = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[currentNoteIndex])")
    }
    
//    var noteOnStaffPanGestureRecognizerLocation: CGFloat = 0
    
    var locationTracker: Double = Double(whiteNotesOnLargeKeyboard.count / 2) {
        didSet {
            currentNoteIndex = Int(round(locationTracker))
            updateNoteOnStaffImage()
        }
    }
    
    func updateNoteOnStaffImage() {
//        while locationTracker > 0 && locationTracker < whiteNotesOnLargeKeyboard.count {
        print("locationTracker: \(locationTracker)")
        print("currentNoteIndex: \(currentNoteIndex)")
        noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[currentNoteIndex])")
//        }
    }
    
    @IBAction func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
//        noteOnStaffPanGestureRecognizerLocation = recognizer.location(in: self.noteOnStaffImage).y
        
        print(recognizer.velocity(in: self.view).y)
        
        if recognizer.velocity(in: self.view).y < 0 && Int(locationTracker) < whiteNotesOnLargeKeyboard.count - 1 {
            print("panning up!")
            locationTracker += 0.17
            
            if recognizer.velocity(in: self.view).y < -150 && Int(locationTracker) < whiteNotesOnLargeKeyboard.count - 1 {
                locationTracker += 0.5
            }
        
        } else if recognizer.velocity(in: self.view).y > 0 && locationTracker > 0 {
            locationTracker -= 0.17
            print("panning down!")
            
            if recognizer.velocity(in: self.view).y > 150 && locationTracker > 0 {
                locationTracker -= 0.5
            }
        }
        
    }
    
}
