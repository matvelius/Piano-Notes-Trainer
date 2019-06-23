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

struct AppData: Codable {
    
//    var levelsCompleted = [Level]()
    
//    required init(from decoder: Decoder) throws {
//        <#code#>
//    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("pianoAppData").appendingPathExtension("plist")
    
    static func saveToFile(levelsCompleted: [Int]) {
        
        let propertyListEncoder = PropertyListEncoder()
        
        let encodedData = try? propertyListEncoder.encode(levelsCompleted)
        
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
        
        print("DATA SAVED TO FILE")
        
    }
    
    static func loadFromFile() -> [Int]? {
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedData = try? Data(contentsOf: AppData.archiveURL),
            let decodedData = try?
                propertyListDecoder.decode(Array<Int>.self, from: retrievedData) {
            return decodedData
        }

        return nil
    }
    
}

let labelScaleMultiplier = 1.2
let labelScaleMultiplierBackToNormal = 1.0







