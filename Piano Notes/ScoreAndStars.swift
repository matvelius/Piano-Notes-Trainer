//
//  ScoreAndStars.swift
//  Piano Notes
//
//  Created by Matvey on 6/4/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import Foundation

// placeholder variable for keeping the score
var totalScore = 0
// current number of stars
var currentNumberOfStars = 0
// keeping track of correct answers in a row to give stars
var correctAnswersInARow = 0
// keeping track of incorrect answers in a row to take away stars
var incorrectAnswersInARow = 0

// decide whether or not to give/take some stars
func giveOrTakeAStar() {
    
    // add stars when user gets 5, 10, 15, 20, 25 correct answers in a row
    switch correctAnswersInARow {
    case 5:
        if currentNumberOfStars < 1 {
            currentNumberOfStars = 1
        }
    case 10:
        if currentNumberOfStars < 2 {
            currentNumberOfStars = 2
        }
    case 15:
        if currentNumberOfStars < 3 {
            currentNumberOfStars = 3
        }
    case 20:
        if currentNumberOfStars < 4 {
            currentNumberOfStars = 4
        }
    case 25:
        if currentNumberOfStars < 5 {
            currentNumberOfStars = 5
        }
    default:
        break
    }
    
    // take away a star each time user gets 3 answers in a row incorrectly
    if incorrectAnswersInARow == 3 {
        // only take away stars if the user actually has them
        if currentNumberOfStars > 0 {
            currentNumberOfStars -= 1
        }
        // reset number of incorrect answers in a row
        incorrectAnswersInARow = 0
    }
    
//    stars.image = UIImage(named: "stars\(currentNumberOfStars)")
}
