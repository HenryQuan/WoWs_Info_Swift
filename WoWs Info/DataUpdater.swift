//
//  DataUpdater.swift
//  WoWs Info
//
//  Created by Henry Quan on 5/6/17.
//  Copyright © 2017 Henry Quan. All rights reserved.
//

import UIKit
import Kanna

class DataUpdater {
    
    static func update() -> Bool {
        // Get path for ExpectedValue.json
        do {
            let data = try HTML(url: URL(string: "https://raw.githubusercontent.com/HenryQuan/WoWs-Info-Re/API/json/personal_rating.json")!, encoding: .utf8)
            // Try to update data
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
            if let pathUrl = path.appendingPathComponent("ExpectedValue.json") {
                print(pathUrl.path)
                // Write to document
                try data.text?.write(to: pathUrl, atomically: false, encoding: .utf8)
                // Success
                return true
            }
        } catch let error as NSError {
            // Error
            print("Error: \(error)")
        }
        return false
    }
    
    static func hasData() -> Bool {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL
        if let pathUrl = path.appendingPathComponent("ExpectedValue.json") {
            return FileManager().fileExists(atPath: pathUrl.path)
        }
        return false
    }

}
