//
//  Accidentals.swift
//  Piano Notes
//
//  Created by Matvey on 4/29/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import Foundation

// keeping track of the accidentals
enum Accidentals: CaseIterable {
    case sharp
    case flat
    case neither
}

var currentAccidental: Accidentals = .neither
