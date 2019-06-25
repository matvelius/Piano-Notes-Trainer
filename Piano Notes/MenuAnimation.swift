//
//  MenuAnimation.swift
//  Piano Notes
//
//  Created by Matvey on 6/8/19.
//  Copyright © 2019 Matvey. All rights reserved.
//
import Foundation
import UIKit

var menuIsClosed = true

// TODO: - add an "if a setting was changed" condition

extension NoteNamesViewController {
    
    func openMenu() {
    
        self.menuTrailingConstraint.constant = 0
    
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
    
            self.view.layoutIfNeeded()
            self.menuButtonOutlet.alpha = 0
            self.darkOverlayOutlet.alpha = 0.73
            self.menuContainerOutlet.alpha = 1
    
        })
    
        self.menuButtonOutlet.setTitle("✕", for: .normal)
    
        UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseIn, animations: {
            self.menuButtonOutlet.alpha = 1
            self.view.layoutIfNeeded()
        })
    
        menuIsClosed = false
    
    }
    
    func closeMenu() {
    
        self.menuTrailingConstraint.constant = 460
    
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
    
            self.view.layoutIfNeeded()
            self.menuButtonOutlet.alpha = 0
            self.darkOverlayOutlet.alpha = 0
            self.menuContainerOutlet.alpha = 0
    
        })
    
        self.menuButtonOutlet.setTitle("☰", for: .normal)
    
        UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseIn, animations: {
            self.menuButtonOutlet.alpha = 1
            self.view.layoutIfNeeded()
        })
    
        menuIsClosed = true
    
    }
    
}

extension NotesOnStaffViewController {
        
    func openMenu() {
        
        self.menuTrailingConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            
            self.view.layoutIfNeeded()
            self.menuButtonOutlet.alpha = 0
            self.darkOverlayOutlet.alpha = 0.73
            self.menuContainerOutlet.alpha = 1
            
        })
        
        self.menuButtonOutlet.setTitle("✕", for: .normal)
        
        UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseIn, animations: {
            self.menuButtonOutlet.alpha = 1
            self.view.layoutIfNeeded()
        })
        
        menuIsClosed = false
        
        noteRangeLowNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[lowNoteIndex])")
        noteRangeHighNoteImage.image = UIImage(named: "staff\(whiteNotesOnLargeKeyboard[highNoteIndex])")
        
    }
    
    func closeMenu() {
        
        self.menuTrailingConstraint.constant = 550
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            
            self.view.layoutIfNeeded()
            self.menuButtonOutlet.alpha = 0
            self.darkOverlayOutlet.alpha = 0
            self.menuContainerOutlet.alpha = 0
            
        })
        
        self.menuButtonOutlet.setTitle("☰", for: .normal)
        
        UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseIn, animations: {
            self.menuButtonOutlet.alpha = 1
            self.view.layoutIfNeeded()
        })
        
        menuIsClosed = true
        
        // FIXME: - WHAT TO DO WITH CURRENT NOTE CHOICES.. UPDATE IF NEEDED, RIGHT? NOT SURE ABOUT THIS!!
        
        if onlyTrebleClefBlackNotesEnabled {
            
            var tempKeyLow = whiteNotesOnLargeKeyboard[lowNoteIndex]
            if tempKeyLow.contains("Bass") {
                tempKeyLow.removeLast(4)
                tempKeyLow.insert("#", at: tempKeyLow.index(before: tempKeyLow.endIndex))
                tempKeyLow.append("Bass")
            } else {
                tempKeyLow.insert("#", at: tempKeyLow.index(before: tempKeyLow.endIndex))
            }

            
            var tempKeyHigh = whiteNotesOnLargeKeyboard[highNoteIndex]
            if tempKeyHigh.contains("Bass") {
                tempKeyHigh.removeLast(4)
                tempKeyHigh.insert("#", at: tempKeyHigh.index(before: tempKeyHigh.endIndex))
                tempKeyHigh.append("Bass")
            } else {
                tempKeyHigh.insert("#", at: tempKeyHigh.index(before: tempKeyHigh.endIndex))
            }
            
            print("onlyTrebleClefBlackNotesEnabled, tempKeyLow: \(tempKeyLow)")
            print("onlyTrebleClefBlackNotesEnabled, tempKeyHigh: \(tempKeyHigh)")
            
            let tempLowNoteIndex = onlyTrebleClefBlackNotes.index(of: tempKeyLow)!
            let tempHighNoteIndex = onlyTrebleClefBlackNotes.index(of: tempKeyHigh)!
            
            currentNoteChoices = Array(onlyTrebleClefBlackNotes[tempLowNoteIndex...tempHighNoteIndex])
            
        } else if onlyBassClefBlackNotesEnabled {
            
            var tempKeyLow = whiteNotesOnLargeKeyboard[lowNoteIndex]
            if tempKeyLow.contains("Bass") {
                tempKeyLow.removeLast(4)
                tempKeyLow.insert("#", at: tempKeyLow.index(before: tempKeyLow.endIndex))
                tempKeyLow.append("Bass")
            } else {
                tempKeyLow.insert("#", at: tempKeyLow.index(before: tempKeyLow.endIndex))
            }
            
            
            var tempKeyHigh = whiteNotesOnLargeKeyboard[highNoteIndex]
            if tempKeyHigh.contains("Bass") {
                tempKeyHigh.removeLast(4)
                tempKeyHigh.insert("#", at: tempKeyHigh.index(before: tempKeyHigh.endIndex))
                tempKeyHigh.append("Bass")
            } else {
                tempKeyHigh.insert("#", at: tempKeyHigh.index(before: tempKeyHigh.endIndex))
            }
            
            print("onlyBassClefBlackNotesEnabled, tempKeyLow: \(tempKeyLow)")
            print("onlyBassClefBlackNotesEnabled, tempKeyHigh: \(tempKeyHigh)")
            
            let tempLowNoteIndex = onlyBassClefBlackNotes.index(of: tempKeyLow)!
            let tempHighNoteIndex = onlyBassClefBlackNotes.index(of: tempKeyHigh)!
            
            currentNoteChoices = Array(onlyBassClefBlackNotes[tempLowNoteIndex...tempHighNoteIndex])
        
        } else if allAccidentalsEnabled || onlySharpsEnabled || onlyFlatsEnabled {
            
            print("allAccidentalsEnabled || onlySharpsEnabled || onlyFlatsEnabled, whiteNotesOnLargeKeyboard[lowNoteIndex]: \(whiteNotesOnLargeKeyboard[lowNoteIndex]), whiteNotesOnLargeKeyboard[highNoteIndex]: \(whiteNotesOnLargeKeyboard[highNoteIndex])")

            let tempLowNoteIndex = allNotesOnLargeKeyboard.index(of: whiteNotesOnLargeKeyboard[lowNoteIndex])!
            let tempHighNoteIndex = allNotesOnLargeKeyboard.index(of: whiteNotesOnLargeKeyboard[highNoteIndex])!
            
            currentNoteChoices = Array(allNotesOnLargeKeyboard[tempLowNoteIndex...tempHighNoteIndex])
            
        } else {
            
            currentNoteChoices = Array(whiteNotesOnLargeKeyboard[lowNoteIndex...highNoteIndex])
            
        }
        
        print("currentNoteChoices: \(currentNoteChoices)")
        setRandomNewNoteUpperIndex()
        
        if currentGameMode == .A {
            noteOnStaffImage.image = UIImage(named: "staffC4")
        }
        
        startNewRound()
//        noteRangeLowNoteImage.image = UIImage(named: "staff\(currentNoteChoices[lowNoteIndex])")
//        noteRangeHighNoteImage.image = UIImage(named: "staff\(currentNoteChoices[lowNoteIndex])")
        
    }
        
}
