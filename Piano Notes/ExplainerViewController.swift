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
    var explainerEndIndex = 5
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var explainerImage: UIImageView!
    
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        segueToGame()
    }
    
    @IBOutlet weak var navTriangleLeft: UIButton!
    
    @IBOutlet weak var navTriangleRight: UIButton!
    
    @IBAction func navTriangleLeftPressed(_ sender: UIButton) {
        
        if explainerStartIndex > 1 {
            
            explainerStartIndex -= 1
            explainerImage.image = UIImage(named: "explainer_\(explainerStartIndex)")
            
            if explainerStartIndex == 1 {
                
                navTriangleLeft.isEnabled = false
                
            }
            
        }
        
    }
    
    @IBAction func navTriangleRightPressed(_ sender: UIButton) {
        
        if explainerStartIndex < explainerEndIndex {
            
            explainerStartIndex += 1
            explainerImage.image = UIImage(named: "explainer_\(explainerStartIndex)")
            
            progressBar.setProgress(Float(explainerStartIndex) / Float(explainerEndIndex), animated: true)
            
        } else {
            
            segueToGame()
            
        }
        
        navTriangleLeft.isEnabled = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    
        switch currentGameType {
        case .noteNames:
            explainerStartIndex = 1
            explainerEndIndex = 5
        case .notesOnStaff:
            explainerStartIndex = 6
            explainerEndIndex = 8
        }
        
        explainerImage.image = UIImage(named: "explainer_\(explainerStartIndex)")
        
        navTriangleLeft.isEnabled = false
        
        navTriangleLeft.setImage(UIImage(named: "nav_triangle_L_inactive"), for: UIControl.State.disabled)
        
        navTriangleRight.setImage(UIImage(named: "nav_triangle_R_normal"), for: UIControl.State.normal)
        
        progressBar.setProgress(Float(explainerStartIndex) / Float(explainerEndIndex), animated: true)
    }
    
    func segueToGame() {
        
        switch currentGameType {
        case .noteNames:
            performSegue(withIdentifier: "doneExplainingToNoteNames", sender: nil)
        case .notesOnStaff:
            performSegue(withIdentifier: "doneExplainingToNotesOnStaff", sender: nil)
        }

    }

}
