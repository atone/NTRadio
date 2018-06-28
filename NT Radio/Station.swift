//
//  Station.swift
//  NT Radio
//
//  Created by Naitong Yu on 2018/6/27.
//  Copyright © 2018年 Naitong Yu. All rights reserved.
//

import Foundation

struct Station {
    let name: String
    let url: URL
    
    static let all = allStations()
    
    private static func allStations() -> [Station] {
        var stations = [Station]()
        let configPath = Bundle.main.path(forResource: "Stations", ofType: "plist")
        let configDict = NSDictionary(contentsOfFile: configPath!)
        if let stationDict = configDict as? [String: Any],
            let stationNames = stationDict["StationName"] as? [String],
            let stationURLs = stationDict["StationURL"] as? [String] {
            for (index, name) in stationNames.enumerated() {
                stations.append(Station(name: name, url: URL(string: stationURLs[index])!))
            }
        }
        return stations
    }
}

extension Station: CustomStringConvertible {
    var description: String {
        return name
    }
}

extension Station: Equatable {
    static func ==(lhs: Station, rhs: Station) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}
