//
//  MiscSettings.swift
//  Piano Notes
//
//  Created by Matvey on 6/12/19.
//  Copyright © 2019 Matvey. All rights reserved.
//

import Foundation
import AVFoundation

// instance variable to hold the AVAudioPlayer object
var audioPlayer: AVAudioPlayer?
var soundsEnabled = true

struct dataToSavePrototype: Codable {
    var levelsCompleted: [Int]
    var miscSettings: [Bool]
    
    init(levelsCompleted: [Int], miscSettings: [Bool]) {
        self.levelsCompleted = levelsCompleted
        self.miscSettings = miscSettings
    }
}

var dataToSaveForCurrentUser = dataToSavePrototype(levelsCompleted: [0], miscSettings: [true])

struct AppData: Codable {
    
//    var levelsCompleted = [Level]()
    
//    required init(from decoder: Decoder) throws {
//        <#code#>
//    }
//    static var dataToSaveForCurrentUser: dataToSavePrototype? = nil
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("pianoAppData").appendingPathExtension("plist")
    
    static func saveToFile(dataToSave: dataToSavePrototype) {
        
        let propertyListEncoder = PropertyListEncoder()
        
        let encodedData = try? propertyListEncoder.encode(dataToSave)
        
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        
        print("DATA SAVED TO FILE")
        
    }
    
    static func loadFromFile() -> dataToSavePrototype? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedData = try? Data(contentsOf: AppData.archiveURL),
            let decodedData = try?
                propertyListDecoder.decode(dataToSavePrototype.self, from: retrievedData) {
            return decodedData
        }

        return nil
    }
    
}

let labelScaleMultiplier = 1.2
let labelScaleMultiplierBackToNormal = 1.0

let labelScaleMultiplierNotesOnStaff = 1.0
let labelScaleMultiplierBackToNormalNotesOnStaff = 0.9







