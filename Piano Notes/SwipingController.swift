//
//  SwipingController.swift
//  Piano Notes
//
//  Created by Matvey on 6/19/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

var currentSlideIndex = 0

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
//        collectionView?.backgroundColor = .white
//        collectionView.register(LessonSlideCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    }
    
    // implement various sections here, or pass in each section?
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        <#code#>
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("lesson1.count: \(lesson1.count)")
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! LessonSlideCollectionViewCell
//        cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .green
        currentSlideIndex = indexPath.row
        print("currentSlideIndex: \(currentSlideIndex)")
        print("named: lesson1[currentSlideIndex]: \(lesson1[currentSlideIndex])")
        let image = UIImage(named: lesson1[currentSlideIndex])
//        let imageView = UIImageView(image: image)
        cell.slideImage.image = image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
