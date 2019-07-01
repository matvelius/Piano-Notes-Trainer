//
//  SwipingController.swift
//  Piano Notes
//
//  Created by Matvey on 6/19/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import UIKit

var currentSlideIndex = 0
var currentLesson = 0

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height: CGFloat = self.view.frame.height
        let width: CGFloat = self.view.frame.width
        
        let myLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        myLayout.itemSize = CGSize(width: width, height: height)
        

        
        collectionView?.isPagingEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // let height: CGFloat = -50 //whatever height you want to add to the existing height
//        let bounds = self.navigationController!.navigationBar.bounds
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: -20, width: bounds.width, height: bounds.height/2)
//        self.navigationController?.navigationBar.heightAnchor.constraint(equalToConstant: CGFloat(1))
//        let size = CGSize(width: UIScreen.main.bounds.size.width, height: 100)
//        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    // implement various sections here, or pass in each section?
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        <#code#>
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("lesson1.count: \(lesson1.count)")
        return allLessons[currentLesson].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! LessonSlideCollectionViewCell
//        cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .green
        currentSlideIndex = indexPath.row
//        let currentLessonToShow = currentLesson
        print("currentSlideIndex: \(currentSlideIndex)")
        
        
        // when user swipes to last slide, append to lessonsCompleted
        if currentSlideIndex == allLessons[currentLesson].count - 1 {
            lessonsCompleted.append(currentLesson)
            print("lessonsCompleted: \(lessonsCompleted)")
        }
//        print("named: lesson1[currentSlideIndex]: \(lesson1[currentSlideIndex])")
//        print("swiping!")
        let image = UIImage(named: allLessons[currentLesson][currentSlideIndex])
//        let imageView = UIImageView(image: image)
        cell.slideImage.image = image
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.1)
        cell.selectedBackgroundView = selectedView

        
//        progressViewOutlet.setProgress(Float(currentSlideIndex + 1)/Float(lesson1.count), animated: true)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        backButtonOutlet.alpha = 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        backButtonOutlet.alpha = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: view.frame.height)
        return CGSize.init(width: collectionView.bounds.width,
        height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
