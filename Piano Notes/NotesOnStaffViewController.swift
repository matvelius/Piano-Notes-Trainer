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
        
        
        if recognizer.velocity(in: self.view).y < 0 && locationTracker < whiteNotesOnLargeKeyboard.count - 1 {
            print("panning up!")
            locationTracker += 1
        
        } else if recognizer.velocity(in: self.view).y > 0 && locationTracker > 0 {
            locationTracker -= 1
            print("panning down!")
        }
        

    }
    

}
