//
//  FromPaintCode.swift
//  Piano Notes
//
//  Created by Matvey on 5/2/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

@IBDesignable
class FromPaintCode: UIView {
    
    override func draw(_ rect: CGRect) {
        StyleKit.drawA5(frame: self.bounds)
    }
    
    //MARK:- Hit TAP
    @objc public func tapDetected(tapRecognizer: UITapGestureRecognizer) {
        let tapLocation: CGPoint = tapRecognizer.location(in: self)
        self.hitTest(tapLocation: CGPoint(x: tapLocation.x, y: tapLocation.y))
    }
    
    func hitTest(tapLocation: CGPoint) {
        let path: UIBezierPath = currentBezierPath
        
        if path.contains(tapLocation) {
            print("tap inside bezier path detected!")
        } else {
            print("tap outside bezier path detected!")
        }
    }
  
}
