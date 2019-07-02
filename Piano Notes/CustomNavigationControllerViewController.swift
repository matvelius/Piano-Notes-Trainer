//
//  CustomNavigationControllerViewController.swift
//  Piano Notes
//
//  Created by Matvey on 7/2/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class CustomNavigationControllerViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }

}
