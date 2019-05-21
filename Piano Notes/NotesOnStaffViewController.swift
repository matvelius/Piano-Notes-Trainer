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
    
    var currentNoteIndex = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[locationTracker])")
        // Do any additional setup after loading the view.
    }
    
    var noteOnStaffPanGestureRecognizerLocation: CGFloat = 0
    
    var locationTracker: Int = whiteNotesOnLargeKeyboard.count / 2 {
        didSet {
            updateNoteOnStaffImage()
        }
    }
    
    func updateNoteOnStaffImage() {
//        while locationTracker > 0 && locationTracker < whiteNotesOnLargeKeyboard.count {
            print("locationTracker: \(locationTracker)")
            noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[locationTracker])")
//        }
    }
    
    @IBAction func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        noteOnStaffPanGestureRecognizerLocation = recognizer.location(in: self.noteOnStaffImage).y
        
        print(noteOnStaffPanGestureRecognizerLocation)
        
//        locationTracker = noteOnStaffPanGestureRecognizerLocation
//
//        if recognizer.state == .began {
//
//            if noteOnStaffPanGestureRecognizerLocation > 0 {
//                print("panning up!")
//                noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[currentNoteIndex + 1])")
//            } else {
//                print("panning down!")
//                noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[currentNoteIndex - 1])")
//            }
//
//        }
        
        
        
        
        if recognizer.velocity(in: self.view).y < 0 && locationTracker < whiteNotesOnLargeKeyboard.count - 1 {
            print("panning up!")
            locationTracker += 1
        
        } else if recognizer.velocity(in: self.view).y > 0 && locationTracker > 0 {
            locationTracker -= 1
            print("panning down!")
        }
        
//        func checkIfPanGestureEnded() {
//            if recognizer.state == .ended {
//                noteOnStaffPanGestureRecognizerLocation = 0
//            }
//        }
        
    }
    

}
