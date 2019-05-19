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
        
        noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[currentNoteIndex])")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        
        
        if recognizer.velocity(in: self.view).y < 0 {
            print("panning up!")
            noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[currentNoteIndex + 1])")
        } else if recognizer.velocity(in: self.view).y > 0 {
            print("panning down!")
            noteOnStaffImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[currentNoteIndex - 1])")
        }
        
    }
    

}
