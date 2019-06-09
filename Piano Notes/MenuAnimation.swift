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

extension ViewController {
    
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
