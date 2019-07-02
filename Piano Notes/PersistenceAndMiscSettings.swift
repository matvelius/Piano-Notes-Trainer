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

struct dataToSavePrototype: Codable {
    var levelsCompleted: [Int]
    var lessonsCompleted: [Int]
    var explainersEnabledNoteNames: Bool
    var explainersEnabledNotesOnStaff: Bool
    var soundsEnabled: Bool
    
    init(levelsCompleted: [Int], lessonsCompleted: [Int], explainersEnabledNoteNames: Bool, explainersEnabledNotesOnStaff: Bool, soundsEnabled: Bool) {
        self.levelsCompleted = levelsCompleted
        self.lessonsCompleted = lessonsCompleted
        self.explainersEnabledNoteNames = explainersEnabledNoteNames
        self.explainersEnabledNotesOnStaff = explainersEnabledNotesOnStaff
        self.soundsEnabled = soundsEnabled
    }
}

var appDataForCurrentUser = dataToSavePrototype(levelsCompleted: [], lessonsCompleted: [], explainersEnabledNoteNames: true, explainersEnabledNotesOnStaff: true, soundsEnabled: true)

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


var levelsCompleted = appDataForCurrentUser.levelsCompleted
var lessonsCompleted = appDataForCurrentUser.lessonsCompleted
var explainersEnabledNoteNames = appDataForCurrentUser.explainersEnabledNoteNames
var explainersEnabledNotesOnStaff = appDataForCurrentUser.explainersEnabledNotesOnStaff
var soundsEnabled = appDataForCurrentUser.soundsEnabled

//{
//    didSet {
//        print("explainersEnabled value changed to: \(explainersEnabled)")
//
//        appDataForCurrentUser.miscSettings[0] = true
//        print("dataToSaveForCurrentUser.miscSettings: \(appDataForCurrentUser.miscSettings)")
//
//        AppData.saveToFile(dataToSave: appDataForCurrentUser)
//    }
//}





