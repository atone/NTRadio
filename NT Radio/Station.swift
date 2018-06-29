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
    
    static var all: [Station] {
        var stations = [Station]()
        for stationDict in AppSetting.shared.stations {
            if let name = stationDict["name"], let url = stationDict["url"] {
                stations.append(Station(name: name, url: URL(string: url)!))
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
