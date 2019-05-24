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
    }
    
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func downArrowButtonPressed(_ sender: UIButton) {
    }
    
    
    
    
    var currentNoteIndex = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[Int(round(locationTracker))])")
    }
    
//    var noteOnStaffPanGestureRecognizerLocation: CGFloat = 0
    
    var locationTracker: Double = Double(whiteNotesOnLargeKeyboard.count / 2) {
        didSet {
            updateNoteOnStaffImage()
        }
    }
    
    func updateNoteOnStaffImage() {
//        while locationTracker > 0 && locationTracker < whiteNotesOnLargeKeyboard.count {
            print("locationTracker: \(locationTracker)")
            noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[Int(round(locationTracker))])")
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
