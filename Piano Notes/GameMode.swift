//
//  GameMode.swift
//  Piano Notes
//
//  Created by Matvey on 5/7/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import Foundation

enum GameMode {
    case A
    case B
}

var currentGameMode: GameMode = .A

enum GameType {
    case noteNames
    case notesOnStaff
}

var currentGameType: GameType = .noteNames
