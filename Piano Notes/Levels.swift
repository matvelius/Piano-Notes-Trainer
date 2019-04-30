//
//  Levels.swift
//  Piano Notes
//
//  Created by Matvey on 4/29/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import Foundation

struct Level {
    
    let title: String
    let subtitle: String
    let imageName: String
    
    let noteChoices: [String]
    
    static var currentLevel: Level = level1
    
}

let level1 = Level(title: "Level 1:", subtitle: "Finding C, D, E", imageName: "level1", noteChoices: onlyCDE)
let level2 = Level(title: "Level 2:", subtitle: "Mastering F, G, A, B", imageName: "level2", noteChoices: onlyFGAB)
let level3 = Level(title: "Level 3:", subtitle: "All the white keys!", imageName: "level3", noteChoices: onlyWhiteKeys)
let level4 = Level(title: "Level 4:", subtitle: "Staying sharp", imageName: "level4", noteChoices: onlyBlackKeys)
let level5 = Level(title: "Level 5:", subtitle: "Fun with flats", imageName: "level5", noteChoices: onlyBlackKeys)
let level6 = Level(title: "Level 6:", subtitle: "Weird enharmonics", imageName: "level6", noteChoices: onlyWeirdEnharmonics)
let level7 = Level(title: "Level 7:", subtitle: "Putting it all together!", imageName: "level7", noteChoices: allNoteChoices)

let allLevels = [level1, level2, level3, level4, level5, level6, level7]
