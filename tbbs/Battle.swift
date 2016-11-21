//
//  Battle.swift
//  tbbs
//
//  Created by Jim Boulter on 8/7/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

enum TerrainType {
    case mountain
    case plains
    case island
    case swamp
    case forest
}

struct WeatherType : OptionSet {
    let rawValue: Int
    
    static let clear = WeatherType(rawValue: 0)
    static let sunny = WeatherType(rawValue: 1 << 0)
    static let rainy = WeatherType(rawValue: 1 << 1)
    static let sandstorm = WeatherType(rawValue: 1 << 2)
    static let pollen = WeatherType(rawValue: 1 << 3)
    static let miasma = WeatherType(rawValue: 1 << 4)
}

class Battle {

    var teams:[[Monster]]
    var terrain:TerrainType
    var weather:WeatherType
    
    init(teams:[[Monster]], terrain:TerrainType = .plains, weather:WeatherType = .clear) {
        self.teams = teams
        self.terrain = terrain
        self.weather = weather
    }
    
}
