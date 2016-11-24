//
//  Monster.swift
//  tbbs
//
//  Created by Jim Boulter on 8/7/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

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
    var moves:[Int]
	var learnableMoves:[Int]
    var name:String
	var experienceCurve:ExperienceCurve
    
    class func monsterWithId(_ id:Int) -> Monster {
        //query for monster
        return Monster()
    }
    
    init() {
        id = 0
		level = 5
        health = 100
        experience = 69
        moves = [0,1,2,3]
		learnableMoves = [0,1,2,3]
		experienceCurve = .slow
        name = "Monster"
    }
	
	var experienceRequiredToLevel:Int {
		if level == 100 {
			return Int.max
		}
		return experienceCurve.experienceRequired(level+1) - experienceCurve.experienceRequired(level)
	}
	
	func hasExperienceToLevelUp() -> Bool{
		return level < 100 && self.experience >= experienceCurve.experienceRequired(level+1)
	}
}
