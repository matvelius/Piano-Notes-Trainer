//
//  InitialViewController.swift
//  Piano Notes
//
//  Created by Matvey on 4/14/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

var currentSection = 0

class InitialViewController: UIViewController {
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        currentSection = sender.tag
        performSegue(withIdentifier: "toSections", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSections" {
            if let vc = segue.destination as? UITabBarController {
                vc.modalPresentationStyle = .fullScreen
                vc.selectedIndex = currentSection
            }
        }
    }
    

}
