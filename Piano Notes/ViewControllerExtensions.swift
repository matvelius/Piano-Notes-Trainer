//
//  ViewControllerExtensions.swift
//  Piano Notes
//
//  Created by Matvey on 6/30/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // function for adding subviews
    func addSameSize(subview: UIView, onTopOf superview: UIView) {
        superview.addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        subview.widthAnchor.constraint(equalTo: superview.widthAnchor).isActive = true
        subview.heightAnchor.constraint(equalTo: superview.heightAnchor).isActive = true
        
        subview.contentMode = superview.contentMode
    }
    
}

extension UINavigationBar {
    func installBlurEffect() {
        isTranslucent = true
        setBackgroundImage(UIImage(), for: .default)
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        var blurFrame = bounds
        blurFrame.size.height += statusBarHeight
        blurFrame.origin.y -= statusBarHeight
        let blurView  = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.isUserInteractionEnabled = false
        blurView.frame = blurFrame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurView)
        blurView.layer.zPosition = -1
    }
}
