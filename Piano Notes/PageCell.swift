//
//  PageCell.swift
//  Piano Notes
//
//  Created by Matvey on 6/19/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

var currentSlideIndex = 0

class PageCell: UICollectionViewCell {
    
    let lessonSlideView: UIImageView = {
        let image = UIImage(named: lesson1[currentSlideIndex])
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        currentSlideIndex += 1
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lessonSlideView)
        NSLayoutConstraint.activate([
            lessonSlideView.widthAnchor.constraint(equalToConstant: self.frame.width),
            lessonSlideView.heightAnchor.constraint(equalToConstant: self.frame.height)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
