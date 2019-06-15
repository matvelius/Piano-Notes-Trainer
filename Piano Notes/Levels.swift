//
//  Levels.swift
//  Piano Notes
//
//  Created by Matvey on 4/29/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import Foundation

struct Level {
    
    let id: Int
    let title: String
    let subtitle: String
    let imageName: String
    
    let noteChoices: [String]
    
    static var currentLevel: Level = level1
    
}

// FREE PLAY
let freeplay1 = Level(id: -3, title: "Free Play", subtitle: "Note Names - Mode A", imageName: "freeplay1", noteChoices: allNoteChoices)
let freeplay2 = Level(id: -2, title: "Free Play", subtitle: "Note Names - Mode B", imageName: "freeplay2", noteChoices: allNoteChoices)
let freeplay3 = Level(id: -1, title: "Free Play", subtitle: "Note on Staff - Mode A", imageName: "freeplay3", noteChoices: allNotesOnLargeKeyboard)
let freeplay4 = Level(id: 0, title: "Free Play", subtitle: "Note on Staff - Mode B", imageName: "freeplay4", noteChoices: allNotesOnLargeKeyboard)


// NOTE NAMES
let level1 = Level(id: 1, title: "Level 1:", subtitle: "Finding C, D, E", imageName: "level1", noteChoices: onlyCDE)
let level2 = Level(id: 2, title: "Level 2:", subtitle: "Mastering F, G, A, B", imageName: "level2", noteChoices: onlyFGAB)
let level3 = Level(id: 3, title: "Level 3:", subtitle: "All the white keys!", imageName: "level3", noteChoices: onlyWhiteKeys)
let level4 = Level(id: 4, title: "Level 4:", subtitle: "Staying sharp", imageName: "level4", noteChoices: onlyBlackKeys)
let level5 = Level(id: 5, title: "Level 5:", subtitle: "Fun with flats", imageName: "level5", noteChoices: onlyBlackKeys)
let level6 = Level(id: 6, title: "Level 6:", subtitle: "Weird enharmonics", imageName: "level6", noteChoices: onlyWeirdEnharmonics)
let level7 = Level(id: 7, title: "Level 7:", subtitle: "Putting it all together!", imageName: "level7", noteChoices: allNoteChoices)

// NOTES ON STAFF
let level8 = Level(id: 8, title: "Level 8:", subtitle: "Meet the Guide Notes", imageName: "level8", noteChoices: onlyGuideNotes)
let level9 = Level(id: 9, title: "Level 9:", subtitle: "Middle C to Treble G", imageName: "level9", noteChoices: onlyMiddleCToTrebleG)
let level10 = Level(id: 10, title: "Level 10:", subtitle: "Bass F to Middle C", imageName: "level1", noteChoices: onlyBassFToMiddleC)
let level11 = Level(id: 11, title: "Level 11:", subtitle: "Bass F to Treble G", imageName: "level1", noteChoices: onlyBassFToTrebleG)
let level12 = Level(id: 12, title: "Level 12:", subtitle: "Mnemonics practice", imageName: "level1", noteChoices: allMnemonics)
let level13 = Level(id: 13, title: "Level 13:", subtitle: "Focus on the black keys", imageName: "level1", noteChoices: blackNotesOnLargeKeyboard)
let level14 = Level(id: 14, title: "Level 14:", subtitle: "All the notes now!", imageName: "level1", noteChoices: allNotesOnLargeKeyboard)


let allLevels = [[level1, level2, level3, level4, level5, level6, level7], [level8, level9, level10, level11, level12, level13, level14]]
