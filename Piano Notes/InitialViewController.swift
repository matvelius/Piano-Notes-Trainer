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

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func firstBtnAction(_ sender: Any) {
//        (sender as! UIButton).tag = 0
//        performSegue(withIdentifier: "tabBar", sender: sender)
//    }
//    @IBAction func secBtnAction(_ sender: Any) {
//        (sender as! UIButton).tag = 1
//        performSegue(withIdentifier: "tabBar", sender: sender)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSections" {
            if let vc = segue.destination as? UITabBarController {
                vc.selectedIndex = currentSection
            }
        }
    }
    
//    let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
//    tabBarController.selectedIndex = tabIndex
//    self.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: {})
    
//    override func viewDidAppear(_ animated: Bool) {
//    
//        let navBar = self.navigationController?.navigationBar
//        
//        navBar?.isHidden = true
////        navBar?.backgroundColor = UIColor.red
//    
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
