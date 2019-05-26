//
//  MusicalAlphabet.swift
//  Piano Notes
//
//  Created by Matvey on 4/12/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import Foundation

let enharmonicEquivalenceCollection = [("A", nil), ("A#", "Bb"), ("B", "Cb"), ("C", "B#"), ("C#", "Db"), ("D", nil), ("D#", "Eb"), ("E", "Fb"), ("F", "E#"), ("F#", "Gb"), ("G", nil), ("G#", "Ab")]

func getEnharmonic(currentNote: String) -> String? {
    
    for (noteOne, noteTwo) in enharmonicEquivalenceCollection {
        if noteOne == currentNote {
            return noteTwo
        } else if noteTwo == currentNote {
            return noteOne
        }
    }
    
    print("DIDN'T FIND ENHARMONIC EQUIVALENT!")
    return nil

}
