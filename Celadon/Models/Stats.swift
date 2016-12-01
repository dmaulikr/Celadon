//
//  Stats.swift
//  Celadon
//
//  Created by Jim Boulter on 11/30/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

struct Stats : ExpressibleByArrayLiteral {
    var healthPoints:Int = 0
    var attack:Int = 0
    var defense:Int = 0
    var specialAttack:Int = 0
    var specialDefense:Int = 0
    var speed:Int = 0
	
	init(arrayLiteral elements: Int...) {
		for i in 0..<elements.count {
			if let stat = Stat(rawValue: i) {
				self[stat] = elements[i]
			} else {
				return
			}
		}
	}
    
    subscript(_ stat:Stat) -> Int {
		get {
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
		set(newValue) {
			switch stat {
			case .healthPoints:
				healthPoints = newValue
			case .attack:
				attack = newValue
			case .defense:
				defense = newValue
			case .specialAttack:
				specialAttack = newValue
			case .specialDefense:
				specialDefense = newValue
			case .speed:
				speed = newValue
			}
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
	
	static func max() -> Stat {
		return .speed
	}
}
