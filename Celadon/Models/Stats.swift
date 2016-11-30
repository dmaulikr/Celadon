//
//  Stats.swift
//  Celadon
//
//  Created by Jim Boulter on 11/30/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

struct Stats {
    var healthPoints:Int
    var attack:Int
    var defense:Int
    var specialAttack:Int
    var specialDefense:Int
    var speed:Int
    
    subscript(_ stat:Stat) -> Int {
        switch stat {
        case .healthPoints:
            return healthPoints
        case .attack:
            return attack
        case .defense:
            return defense
        case .specialAttack:
            return specialAttack
        case .specialDefense:
            return specialDefense
        case .speed:
            return speed
        }
    }
}



enum Stat : Int {
    case healthPoints = 0
    case attack = 1
    case defense = 2
    case specialAttack = 3
    case specialDefense = 4
    case speed = 5
    
    case none = -1
}
