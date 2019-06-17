//
//  Alert.swift
//  Piano Notes
//
//  Created by Matvey on 6/16/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import Foundation
import UIKit

let title = "Level finished!".uppercased()
let message = "Congrats, you have earned 5 stars!"



struct Alert {
    
    static func showFinishLevelAlert(on vc: NoteNamesViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Keep playing", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Back to menu", style: .default, handler: { (action: UIAlertAction!) in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let backToLevels = storyBoard.instantiateViewController(withIdentifier: "Levels") as! LevelsTableViewController
            vc.present(backToLevels, animated:true, completion:nil)

            }))
        alert.addAction(UIAlertAction(title: "Next level", style: .cancel, handler: nil))
        vc.present(alert, animated: true)
    }
    
}
