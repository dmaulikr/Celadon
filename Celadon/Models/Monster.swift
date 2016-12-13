//
//  Monster.swift
//  Celadon
//
//  Created by Jim Boulter on 8/7/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

class Monster : Hashable {
	
	/// The hash value.
	///
	/// Hash values are not guaranteed to be equal across different executions of
	/// your program. Do not save hash values to use during a future execution.
	public var hashValue: Int
	var id:Int
	var currentHealth:Int {
		didSet {
			if currentHealth <= 0 {
				faint()
			} else if currentHealth > healthPoints {
				currentHealth = healthPoints
			}
		}
	}
	var experience:Int {
		didSet {
			if experience == Int.max {
				experience = Int.max - 1
			}
		}
	}
    var moves:[Move]
	var learnableMoves:Set<Move>
    var name:String
	var experienceCurve:ExperienceCurve
	let nature:Nature
	var types:Set<Type>
	var statusCondition:StatusCondition
	var specialCondition:SpecialCondition
	
	private let baseStats:Stats
	private let individualValues:Stats
	private var experienceValues:Stats
	
    static func monsterWithId(_ id:Int) -> Monster {
        //query for monster
        return Monster()
    }
    
    init() {
		
		hashValue = UUID().hashValue
		
        id = 0
        experience = 69
        moves = []
		learnableMoves = []
		experienceCurve = .slow
        name = "Monster"
		baseStats = [1, 1, 1, 1, 1, 1]
		individualValues = [1, 1, 1, 1, 1, 1]
		experienceValues = [1, 1, 1, 1, 1, 1]
		nature = .hardy
		types = [.normal]
		statusCondition = .none
		specialCondition = .none
		currentHealth = Int.max
    }
	
	// MARK: Status change
	
	func faint() {
		currentHealth = 0
		statusCondition = .none
		specialCondition = .none
	}
	
	func canBeInflictedWith(statusCondition:StatusCondition) -> Bool {
		if self.statusCondition != .none {
			return false
		}
		
		//TODO: Check for abilities
		
		switch statusCondition {
		case .paralysis:
			return !self.types.contains(.electric)
		case .poison:
			return !self.types.contains(.poison)
		case .burn:
			return !self.types.contains(.fire)
		default:
			return true
		}
	}
	
	func canBeInflictedWith(specialCondition:SpecialCondition) -> Bool {
		if self.specialCondition != .none {
			return false
		}
		
		//TODO: Check for abilities
		
		return true
	}
	
	func inflict(statusCondition:StatusCondition) {
		if canBeInflictedWith(statusCondition: statusCondition) {
			self.statusCondition = statusCondition
		}
	}
	
	func inflict(specialCondition:SpecialCondition) {
		if canBeInflictedWith(specialCondition: specialCondition) {
			self.specialCondition = specialCondition
		}
	}
	
	// MARK: Stats
	
	var healthPoints:Int {
		get {
			return valueForStat(.healthPoints)
		}
	}
	
	var attack:Int {
		get {
			return valueForStat(.attack)
		}
	}
	
	var defense:Int {
		get {
			return valueForStat(.defense)
		}
	}
	
	var specialAttack:Int {
		get {
			return valueForStat(.specialAttack)
		}
	}
	
	var specialDefense:Int {
		get {
			return valueForStat(.specialDefense)
		}
	}
	
	var speed:Int {
		get {
			return valueForStat(.speed)
		}
	}
	
	func valueForStat(_ stat:Stat) -> Int {
		let numerator:Float = Float((2 * baseStats[stat]) + individualValues[stat]) + (Float(experienceValues[stat])/4.0) * Float(level)
		let frac:Float = numerator / 100.0
		let flr:Float = floor(frac) + 5.0
		
		// hp is calculated a little differently, no nature
		// too much duplication from other calculations for another function
		if stat == .healthPoints {
			return Int(flr) + level + 5
		}
		
		let withNature = flr * Float(nature.multiplierFor(.speed))
		
		return Int(floor(withNature))
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
	
	func awardExperience(_ points:Int) {
		self.experience += points
//		self.levelUp()
	}
	
	func awardExperienceValue(_ value:Int, _ stat:Stat) {
		experienceValues[stat] += value
	}
	
	// MARK: Level
	
	var level:Int {
		return experienceCurve.level(experience)
	}
	
	// MARK: Hashable
	
	public static func ==(lhs: Monster, rhs: Monster) -> Bool {
		return lhs.hashValue == rhs.hashValue
	}
}
