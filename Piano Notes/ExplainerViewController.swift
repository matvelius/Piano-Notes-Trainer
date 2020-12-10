//
//  ExplainerViewController.swift
//  Piano Notes
//
//  Created by Matvey on 3/19/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class ExplainerViewController: UIViewController {
    
    var explainerStartIndex = 1
    var explainerEndIndex = 6
    var explainerCurrentIndex = 1
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var cover: UIView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var explainerImage: UIImageView!
    
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        segueToGame()
    }
    
    @IBOutlet weak var navTriangleLeft: UIButton!
    
    @IBOutlet weak var navTriangleRight: UIButton!
    
    @IBOutlet weak var skip: UIButton!
    
    @IBAction func navTriangleLeftPressed(_ sender: UIButton) {
        
        if explainerCurrentIndex > explainerStartIndex {
            
            explainerCurrentIndex -= 1
            explainerImage.image = UIImage(named: "explainer_\(explainerCurrentIndex)")
            
            if explainerStartIndex == 1 {
                
                navTriangleLeft.isEnabled = false
                
            }
            
            updateProgressBar()
            
        }
        
    }
    
    @IBAction func navTriangleRightPressed(_ sender: UIButton) {
        
        if explainerCurrentIndex < explainerEndIndex {
            
            explainerCurrentIndex += 1
            explainerImage.image = UIImage(named: "explainer_\(explainerCurrentIndex)")
            
            updateProgressBar()
            
        } else {
            
            segueToGame()
            
        }
        
        navTriangleLeft.isEnabled = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainView.alpha = 0
        self.navTriangleLeft.alpha = 0
        self.navTriangleRight.alpha = 0
        self.skip.alpha = 0
        self.progressBar.alpha = 0
        self.explainerImage.alpha = 0
        
        self.cover.alpha = 1
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1) {
            self.mainView.alpha = 1.0
            self.navTriangleLeft.alpha = 1.0
            self.navTriangleRight.alpha = 1.0
            self.skip.alpha = 1.0
            self.progressBar.alpha = 1.0
            self.explainerImage.alpha = 1.0
            
            self.cover.alpha = 0
        }
        
        switch currentGameType {
        case .noteNames:
            explainerStartIndex = 1
            explainerEndIndex = 6
        case .notesOnStaff:
            explainerStartIndex = 7
            explainerEndIndex = 9
        }
        
        explainerCurrentIndex = explainerStartIndex
        
        explainerImage.image = UIImage(named: "explainer_\(explainerCurrentIndex)")
        
        navTriangleLeft.isEnabled = false
        
        navTriangleLeft.setImage(UIImage(named: "nav_triangle_L_inactive"), for: UIControl.State.disabled)
        
        navTriangleRight.setImage(UIImage(named: "nav_triangle_R_normal"), for: UIControl.State.normal)
        
        updateProgressBar()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.mainView.alpha = 0
//        self.navTriangleLeft.alpha = 0
//        self.navTriangleRight.alpha = 0
//        self.skip.alpha = 0
//        self.progressBar.alpha = 0
//        print("view will disappear")
//    }
    
    func segueToGame() {
        
        UIView.animate(withDuration: 1) {
            self.mainView.alpha = 0
            self.navTriangleLeft.alpha = 0
            self.navTriangleRight.alpha = 0
            self.skip.alpha = 0
            self.progressBar.alpha = 0
            self.explainerImage.alpha = 0
            
            self.cover.alpha = 1
        }
        
        switch currentGameType {
        case .noteNames:
            explainersEnabledNoteNames = false
            performSegue(withIdentifier: "doneExplainingToNoteNames", sender: nil)
        case .notesOnStaff:
            explainersEnabledNotesOnStaff = false
            performSegue(withIdentifier: "doneExplainingToNotesOnStaff", sender: nil)
        }

    }
    
    func updateProgressBar() {
        var currentProgress = 0
        var progressBarEndIndex = 5
        
        switch currentGameType {
        case .noteNames:
            currentProgress = explainerCurrentIndex
            progressBarEndIndex = 6
        case .notesOnStaff:
            currentProgress = explainerCurrentIndex - 6
            progressBarEndIndex = 3
        }
        progressBar.setProgress(Float(currentProgress) / Float(progressBarEndIndex), animated: true)
    }

}
