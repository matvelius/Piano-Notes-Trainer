//
//  SectionsTabBarController.swift
//  Piano Notes
//
//  Created by Matvey on 6/22/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

class SectionsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

//        UITabBar.appearance().tintColor = UIColor(red: 254/255.0, green: 105/255.0, blue: 51/255.0, alpha: 100.0)
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        tabBarItem.image = UIImage(named: "tabBarIconLearn")
        tabBar.items?[0].title = "LEARN"
        tabBar.items?[0].image = UIImage(named: "tabBarIconLearn")
//        tabBar.items?[0].imageInsets = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        //        tabBar.items?[0].image?.
        
        tabBar.items?[1].title = "PLAY"
        tabBar.items?[1].image = UIImage(named: "tabBarIconPlay")
//        tabBar.items?[1].imageInsets = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
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
