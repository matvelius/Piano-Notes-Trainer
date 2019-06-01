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

// FOR MODE B
let basicNoteNames = ["A", "B", "C", "D", "E", "F", "G"]
let basicNoteNamesOnlyCDE = ["C", "D", "E"]
let basicNoteNamesOnlyFGAB = ["F", "G", "A", "B"]
let basicNoteNamesOnlyWeirdEnharmonics = ["B", "C", "E", "F"]

// LARGE KEYBOARD -- DEAL WITH C4 AMBIGUITY!
let whiteNotesOnLargeKeyboard = ["C2", "D2", "E2", "F2", "G2", "A2", "B2", "C3", "D3", "E3", "F3", "G3", "A3", "B3", "C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5", "G5", "A5", "B5", "C6"]

let blackNotesOnLargeKeyboard = ["C#2", "D#2", "F#2", "G#2", "A#2", "C#3", "D#3", "F#3", "G#3", "A#3", "C#4", "D#4", "F#4", "G#4", "A#4", "C#5", "D#5", "F#5", "G#5", "A#5", "C#6"]

let allNotesOnLargeKeyboard = whiteNotesOnLargeKeyboard + blackNotesOnLargeKeyboard

let onlyTrebleClefWhiteNotes = ["C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5", "D5", "E5", "F5", "G5", "A5", "B5", "C6"]
let onlyTrebleClefBlackNotes = ["C#4", "D#4", "F#4", "G#4", "A#4", "C#5", "D#5", "F#5", "G#5", "A#5"]
let onlyBassClefWhiteNotes = ["C2", "D2", "E2", "F2", "G2", "A2", "B2", "C3", "D3", "E3", "F3", "G3", "A3", "B3", "C4bass"]
let onlyBassClefBlackNotes = ["C#2", "D#2", "F#2", "G#2", "A#2", "C#3", "D#3", "F#3", "G#3", "A#3", "C#4bass"]

let onlyGuideNotes = ["F3", "C4", "G4"]

// treble clef mnemonics
let onlyFACE = ["F4", "A4", "C5", "E5"]
let onlyEGBDF = ["E4", "G4", "B4", "D5", "F5"]
let onlyTrebleClefMnemonics = onlyFACE + onlyEGBDF

// bass clef mnemonics
let onlyACEG = ["A2", "C3", "E3", "G3"]
let onlyGBDFA = ["G2", "B2", "D3", "F3", "A3"]
let onlyBassClefMnemonics = onlyACEG + onlyGBDFA




// LEVEL SWITCHES
var allNoteChoicesEnabled = false
var onlyWhiteKeysEnabled = true
var onlyBlackKeysEnabled = false
var onlyCDEEnabled = false
var onlyFGABEnabled = false
var onlySharpsEnabled = false
var onlyFlatsEnabled = false
var onlyWeirdEnharmonicsEnabled = false
var weirdEnharmonicsEnabled = false

var randomNewNoteIndexUpperLimit = 0

func setToAllNoteChoices() {
    allNoteChoicesEnabled = true
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = false
    onlyCDEEnabled = false
    onlyFGABEnabled = false
    onlySharpsEnabled = false
    onlyFlatsEnabled = false
    onlyWeirdEnharmonicsEnabled = false
    weirdEnharmonicsEnabled = true
    
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
    onlyWeirdEnharmonicsEnabled = false
    weirdEnharmonicsEnabled = false
    
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
    onlyWeirdEnharmonicsEnabled = false
    weirdEnharmonicsEnabled = false
    
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
    onlyWeirdEnharmonicsEnabled = false
    weirdEnharmonicsEnabled = false
    
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
    onlyWeirdEnharmonicsEnabled = false
    weirdEnharmonicsEnabled = false
    
    currentNoteChoices = onlyFGAB
    setRandomNewNoteUpperIndex()
}

func setToOnlySharps() {
    allNoteChoicesEnabled = false
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = false // CONFIRM THIS IS CORRECT!
    onlyCDEEnabled = false
    onlyFGABEnabled = false
    onlySharpsEnabled = true
    onlyFlatsEnabled = false
    onlyWeirdEnharmonicsEnabled = false
    weirdEnharmonicsEnabled = false
    
    // HOW TO DIFFERENTIATE BETWEEN SHARPS & FLATS
    
    currentNoteChoices = onlyBlackKeys
    setRandomNewNoteUpperIndex()
}

func setToOnlyFlats() {
    allNoteChoicesEnabled = false
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = false // CONFIRM THIS IS CORRECT!
    onlyCDEEnabled = false
    onlyFGABEnabled = false
    onlySharpsEnabled = false
    onlyFlatsEnabled = true
    onlyWeirdEnharmonicsEnabled = false
    weirdEnharmonicsEnabled = false
    
    // HOW TO DIFFERENTIATE BETWEEN SHARPS & FLATS
    
    currentNoteChoices = onlyBlackKeys
    setRandomNewNoteUpperIndex()
}

func setToOnlyWeirdEnharmonics() {
    allNoteChoicesEnabled = false
    onlyWhiteKeysEnabled = false
    onlyBlackKeysEnabled = false
    onlyCDEEnabled = false
    onlyFGABEnabled = false
    onlySharpsEnabled = false
    onlyFlatsEnabled = false
    onlyWeirdEnharmonicsEnabled = true
    weirdEnharmonicsEnabled = true
    
    currentNoteChoices = onlyWeirdEnharmonics
    setRandomNewNoteUpperIndex()
}

func setRandomNewNoteUpperIndex() {
    randomNewNoteIndexUpperLimit = currentNoteChoices.count - 1
}

var lastRandomNumber: Int = -1
var randomNewNoteIndex = Int.random(in: 0...15)

func generateNewRandomNoteIndex() {
    randomNewNoteIndex = Int.random(in: 0...randomNewNoteIndexUpperLimit)
    
    while randomNewNoteIndex == lastRandomNumber {
        randomNewNoteIndex = Int.random(in: 0...randomNewNoteIndexUpperLimit)
    }
}

