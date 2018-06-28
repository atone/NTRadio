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
    }
    
    private init() {
        let initialSetting: [String: Any] = [
            Static.isPlaying: true,
            Static.currentIndex: 0
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
}
