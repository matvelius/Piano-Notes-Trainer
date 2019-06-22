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
    @IBInspectable var customHeight : CGFloat = 10
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("It called")
        
        self.tintColor = .black
        self.backgroundColor = .red
        
        
        
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("UIBarBackground") {
                
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                
                subview.backgroundColor = .blue
                subview.sizeToFit()
            }
            
            stringFromClass = NSStringFromClass(subview.classForCoder)
            
            //Can't set height of the UINavigationBarContentView
            if stringFromClass.contains("UINavigationBarContentView") {
                
                //Set Center Y
                let centerY = (customHeight - subview.frame.height) / 3.0
                subview.frame = CGRect(x: 0, y: centerY, width: self.frame.width, height: subview.frame.height)
                subview.backgroundColor = .green
                subview.sizeToFit()
                
            }
        }
        
        
    }
    
    
}
