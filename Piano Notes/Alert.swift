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
    
    static func showFinishLevelAlert(on vc: ViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Keep playing", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Back to menu", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Next level", style: .cancel, handler: nil))
        vc.present(alert, animated: true)
    }
    
}
