//
//  CustomNavigationBar.swift
//  Piano Notes
//
//  Created by Matvey on 6/21/19.
//  Copyright © 2019 Matvey. All rights reserved.
//
// https://stackoverflow.com/questions/44387285/ios-11-navigation-bar-height-customizing

import UIKit

@IBDesignable
class CINavigationBar: UINavigationBar {
    
    //set NavigationBar's height
    @IBInspectable var customHeight : CGFloat = 5
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("It called")
        
        self.tintColor = UIColor(red:0.00, green:0.40, blue:0.96, alpha:1.0)
        self.backgroundColor = UIColor.clear
        
        
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("UIBarBackground") {
                
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                
                subview.backgroundColor = UIColor.clear
                subview.sizeToFit()
            }
            
            stringFromClass = NSStringFromClass(subview.classForCoder)
            
            //Can't set height of the UINavigationBarContentView
            if stringFromClass.contains("UINavigationBarContentView") {
                
                //Set Center Y
                let centerY = CGFloat(2)
                subview.frame = CGRect(x: 0, y: centerY, width: self.frame.width, height: subview.frame.height)
                subview.backgroundColor = UIColor.clear
                subview.sizeToFit()
                
            }
        }
        
        
    }
    
    
}
