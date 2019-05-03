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
    
    

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        StyleKit.drawA5(frame: self.bounds)
    }
    
    ///Catch layer by tap detection
//    let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapDetected(_:)))
//    self.addGestureRecognizer(tapRecognizer)
    
    
    
    //MARK:- Hit TAP
    @objc public func tapDetected(tapRecognizer: UITapGestureRecognizer) {
        let tapLocation: CGPoint = tapRecognizer.location(in: self)
        self.hitTest(tapLocation: CGPoint(x: tapLocation.x, y: tapLocation.y))
    }
    
//    public func tapDetected(tapRecognizer:UITapGestureRecognizer){
//        let tapLocation:CGPoint = tapRecognizer.location(in: viewSlices)
//        self.hitTest(tapLocation: CGPoint(x: tapLocation.x, y: tapLocation.y))
//    }
    
    func hitTest(tapLocation: CGPoint) {
        let path: UIBezierPath = currentBezierPath
        
        if path.contains(tapLocation) {
            print("tap inside bezier path detected!")
        } else {
            print("tap outside bezier path detected!")
        }
    }
    
//    private func hitTest(tapLocation:CGPoint){
//        let path:UIBezierPath = yourPath
//
//        if path.contains(tapLocation){
//            //tap detected do what ever you want ..;)
//        }else{
//            //ooops you taped on other position in view
//        }
//    }
    
//    let testing = StyleKit.imageOfA5().
    
    

}
