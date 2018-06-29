//
//  AppSetting.swift
//  NT Radio
//
//  Created by Naitong Yu on 2018/6/28.
//  Copyright © 2018年 Naitong Yu. All rights reserved.
//

import Foundation

class AppSetting {
    static let shared = AppSetting()
    private let defaults = UserDefaults.standard
    
    private struct Static {
        static let isPlaying = "radio.isPlaying"
        static let currentIndex = "radio.currentIndex"
        static let stations = "radio.stations"
    }
    
    private init() {
        // Read default station list
        let configPath = Bundle.main.path(forResource: "Stations", ofType: "plist")
        let initialStations = NSArray(contentsOfFile: configPath!) as! [[String:String]]
        
        // Register default settings
        let initialSetting: [String: Any] = [
            Static.isPlaying: true,
            Static.currentIndex: 0,
            Static.stations: initialStations
        ]
        defaults.register(defaults: initialSetting)
    }
    
    var isPlaying: Bool {
        get {
            return defaults.bool(forKey: Static.isPlaying)
        }
        set {
            defaults.set(newValue, forKey: Static.isPlaying)
        }
    }
    
    var currentIndex: Int {
        get {
            return defaults.integer(forKey: Static.currentIndex)
        }
        set {
            defaults.set(newValue, forKey: Static.currentIndex)
        }
    }
    
    var stations: [[String:String]] {
        get {
            if let stations = defaults.array(forKey: Static.stations) as? [[String:String]] {
                return stations
            }
            return [[String:String]]()
        }
        set {
            defaults.set(newValue, forKey: Static.stations)
        }
    }
}
