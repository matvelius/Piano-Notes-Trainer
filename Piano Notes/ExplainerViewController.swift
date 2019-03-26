//
//  ExplainerViewController.swift
//  Piano Notes
//
//  Created by Matvey on 3/19/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class ExplainerViewController: UIViewController {
    
    var explainerIndex = 1
    var numberOfExplainers = 4

    @IBOutlet weak var explainerImage: UIImageView!
    
    @IBOutlet weak var navTriangleLeft: UIButton!
    
    @IBOutlet weak var navTriangleRight: UIButton!
    
    @IBAction func navTriangleLeftPressed(_ sender: UIButton) {
    }
    
    @IBAction func navTriangleRightPressed(_ sender: UIButton) {
        if explainerIndex < numberOfExplainers {
            explainerIndex += 1
            explainerImage.image = UIImage(named: "explainer_\(explainerIndex)")
        } else {
            performSegue(withIdentifier: "doneExplaining", sender: sender)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        explainerImage.image = UIImage(named: "explainer_1")
        
//        imageName = "\(currentUserAnswer)_wrong"
//        let image = UIImage(named: imageName)
//        currentNoteButton.setImage(image, for: UIControl.State.normal)
        
        navTriangleLeft.isEnabled = false
        
        navTriangleLeft.setImage(UIImage(named: "nav_triangle_L_inactive"), for: UIControl.State.disabled)
        
        navTriangleRight.setImage(UIImage(named: "nav_triangle_R_normal"), for: UIControl.State.normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
