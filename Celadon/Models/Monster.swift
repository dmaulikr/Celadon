//
//  Monster.swift
//  tbbs
//
//  Created by Jim Boulter on 8/7/16.
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
	
	subscript(_ statType:StatType) -> Int {
		switch statType {
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

enum StatType {
	case healthPoints
	case attack
	case defense
	case specialAttack
	case specialDefense
	case speed
}

typealias ExperienceValue = (StatType, Int)

class Monster {
    
    var id:Int
	var level:Int {
		didSet {
			if level > 100 {
				level = 100
			} else if level < 1 {
				level = 1
			}
		}
	}
    var health:Int
	var experience:Int
    var moves:[Move]
	var learnableMoves:[Move]
    var name:String
	var experienceCurve:ExperienceCurve
	
	private let baseStats:Stats
	private let individualValues:Stats
	private var experienceValues:Stats
	
	var currentStats:Stats
	
    class func monsterWithId(_ id:Int) -> Monster {
        //query for monster
        return Monster()
    }
    
    init() {
        id = 0
		level = 5
        health = 100
        experience = 69
        moves = []
		learnableMoves = []
		experienceCurve = .slow
        name = "Monster"
		baseStats = [1, 1, 1, 1, 1, 1]
		individualValues = [1, 1, 1, 1, 1, 1]
		experienceValues = [1, 1, 1, 1, 1, 1]
		baseStats = [1, 1, 1, 1, 1, 1]
    }
	
	// MARK: Experience
	
	var experienceRequiredToLevel:Int {
		if level == 100 {
			return Int.max
		}
		return experienceCurve.experienceRequired(level,level+1)
	}
	
	func hasExperienceToLevelUp() -> Bool{
		return level < 100 && self.experience >= experienceCurve.experienceRequired(level+1)
	}
	
	func willLevelWithExperienceAward(_ points:Int) -> Bool {
		return (self.experience + points) > self.experienceRequiredToLevel
	}
	
	func awardExperience(_ points:Int, _ experienceValue:ExperienceValue) {
		self.experience += points
		
		if self.experience > self.experienceRequiredToLevel {
			self.level += 1
			// Consider a delegate method here
		}
		
		self.awardExperienceValue(experienceValue)
	}
	
	func awardExperienceValue(_ ev:ExperienceValue) {
		
	}
}
