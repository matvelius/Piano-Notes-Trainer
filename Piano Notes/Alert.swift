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

let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)


struct Alert {
    
    static func showFinishLevelAlert(on vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Keep playing", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Back to menu", style: .default, handler: { (action: UIAlertAction!) in
            let backToLevels = storyBoard.instantiateViewController(withIdentifier: "Levels") as! LevelsTableViewController
            vc.present(backToLevels, animated: true, completion: nil)
            }))
        
        // decide whether to add the "Next level" button
        if (1)...(6) ~= Level.currentLevel.id {
            alert.addAction(UIAlertAction(title: "Next level", style: .cancel, handler: { (action: UIAlertAction!) in
                    // go to next level
                    Level.currentLevel = allLevels[0][Level.currentLevel.id]
                    let nextNoteNameLevel = storyBoard.instantiateViewController(withIdentifier: "NoteNames") as! NoteNamesViewController
                    vc.present(nextNoteNameLevel, animated: true, completion: nil)
            }))
        } else if (8)...(13) ~= Level.currentLevel.id {
            alert.addAction(UIAlertAction(title: "Next level", style: .cancel, handler:
                { (action: UIAlertAction!) in
                    Level.currentLevel = allLevels[1][Level.currentLevel.id - 7]
                    let nextNotesOnStaffLevel = storyBoard.instantiateViewController(withIdentifier: "NotesOnStaff") as! NotesOnStaffViewController
                    vc.present(nextNotesOnStaffLevel, animated: true, completion: nil)
            }))
        }
        
        vc.present(alert, animated: true)
    }
    
}
