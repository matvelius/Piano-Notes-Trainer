//
//  NoteChoices.swift
//  Piano Notes
//
//  Created by Matvey on 4/29/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import Foundation

//struct NoteChoices {

var currentNoteChoices = [""]

let allNoteChoices = ["F#3", "G3", "G#3", "A3", "A#3", "B3", "C4", "C#4", "D4", "D#4", "E4", "F4", "F#4", "G4", "G#4", "A4", "A#4", "B4", "C5", "C#5",  "D5", "D#5", "E5", "F5", "F#5", "G5", "G#5", "A5", "A#5"]

let onlyWhiteKeys = ["G3", "A3", "B3", "C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5", "G5", "A5"]

let onlyBlackKeys = ["F#3", "G#3", "A#3", "C#4", "D#4", "F#4", "G#4", "A#4", "C#5", "D#5", "F#5", "G#5", "A#5"]

let onlyCDE = ["C4", "D4", "E4", "C5", "D5", "E5"]

let onlyFGAB = ["G3", "A3", "B3", "F4", "G4", "A4", "B4", "F5", "G5", "A5"]

// IMPLEMENT WEIRD ENHARMONICS FOR LEVEL 6!
let onlyWeirdEnharmonics = ["B3", "C4", "E4", "F4", "B4", "C5", "E5", "F5"]

var allNoteChoicesEnabled = false
var onlyWhiteKeysEnabled = true
var onlyBlackKeysEnabled = false
var onlyCDEEnabled = false
var onlyFGABEnabled = false
var onlySharpsEnabled = false
var onlyFlatsEnabled = false

var randomNewNoteIndexUpperLimit = 0

func setToAllNoteChoices() {
    allNoteChoicesEnabled = true
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = false
    onlyCDEEnabled = false
    onlyFGABEnabled = false
    onlySharpsEnabled = false
    onlyFlatsEnabled = false
    
    currentNoteChoices = allNoteChoices
    setRandomNewNoteUpperIndex()
}

func setToOnlyWhiteKeys() {
    allNoteChoicesEnabled = false
    onlyWhiteKeysEnabled = true
    onlyBlackKeysEnabled = false
    onlyCDEEnabled = false
    onlyFGABEnabled = false
    onlySharpsEnabled = false
    onlyFlatsEnabled = false
    
    currentNoteChoices = onlyWhiteKeys
    setRandomNewNoteUpperIndex()
}

func setToOnlyBlackKeys() {
    allNoteChoicesEnabled = false
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = true
    onlyCDEEnabled = false
    onlyFGABEnabled = false
    onlySharpsEnabled = false
    onlyFlatsEnabled = false
    
    currentNoteChoices = onlyBlackKeys
    setRandomNewNoteUpperIndex()
}

func setToOnlyCDE() {
    allNoteChoicesEnabled = false
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = false
    onlyCDEEnabled = true
    onlyFGABEnabled = false
    onlySharpsEnabled = false
    onlyFlatsEnabled = false
    
    currentNoteChoices = onlyCDE
    setRandomNewNoteUpperIndex()
}

func setToOnlyFGAB() {
    allNoteChoicesEnabled = false
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = false
    onlyCDEEnabled = false
    onlyFGABEnabled = true
    onlySharpsEnabled = false
    onlyFlatsEnabled = false
    
    currentNoteChoices = onlyFGAB
    setRandomNewNoteUpperIndex()
}

func setToOnlySharps() {
    allNoteChoicesEnabled = false
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = true // CONFIRM THIS IS CORRECT!
    onlyCDEEnabled = false
    onlyFGABEnabled = false
    onlySharpsEnabled = true
    onlyFlatsEnabled = false
    
    // HOW TO DIFFERENTIATE BETWEEN SHARPS & FLATS
    
    currentNoteChoices = onlyBlackKeys
    setRandomNewNoteUpperIndex()
}

func setToOnlyFlats() {
    allNoteChoicesEnabled = false
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = true // CONFIRM THIS IS CORRECT!
    onlyCDEEnabled = false
    onlyFGABEnabled = false
    onlySharpsEnabled = false
    onlyFlatsEnabled = true
    
    // HOW TO DIFFERENTIATE BETWEEN SHARPS & FLATS
    
    currentNoteChoices = onlyBlackKeys
    setRandomNewNoteUpperIndex()
}

func setRandomNewNoteUpperIndex() {
    randomNewNoteIndexUpperLimit = currentNoteChoices.count - 1
}

let basicNoteNames = ["A", "B", "C", "D", "E", "F", "G"]

//let sharpFlatOrNil = ["#", "b", ""]
