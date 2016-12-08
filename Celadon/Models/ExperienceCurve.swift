//
//  ExperienceCurve.swift
//  Celadon
//
//  Created by Jim Boulter on 11/22/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

enum ExperienceCurve {
	
	static let UndefinedExperience = -1
	
	case fluctuating
	case slow
	case medium_slow
	case medium_fast
	case fast
	case erratic
	
	func level(_ experience:Int) -> Int {
		var high:Int = 100
		var low:Int = 1
		var mid:Int = 50
		
		while high - low > 1 {
			if experienceRequired(low) <= experience && experience < experienceRequired(mid) {
				high = mid
				mid = (high - low) / 2
			} else {
				low = mid
				mid = ((high - low) / 2) + low
			}
		}
		if experience < experienceRequired(high) {
			return low
		} else {
			return high
		}
	}
	
	func experienceRequired(_ from:Int, _ to:Int) -> Int {
		return self.experienceRequired(to) - self.experienceRequired(from)
	}
	
	func experienceRequired(_ level:Int) -> Int {
		switch self {
		case .erratic:
			return self.eratticExperienceRequired(level)
		case .slow:
			return self.slowExperienceRequired(level)
		case .medium_slow:
			return self.mediumSlowExperienceRequired(level)
		case .medium_fast:
			return self.mediumFastExperienceRequired(level)
		case .fast:
			return self.fastExperienceRequired(level)
		case .fluctuating:
			return self.fluctuatingExperienceRequired(level)
		}
	}
	
	private func eratticExperienceRequired(_ level:Int) -> Int {
		var divisor:Int
		var topMultiplier:Int
		if level <= 50 {
			divisor = 50
			topMultiplier = 100 - level
		} else if 50 < level && level <= 68 {
			divisor = 100
			topMultiplier = 150 - level
		} else if 68 < level && level <= 98 {
			divisor = 500
			let dtm:Double = (1911.0 - (10.0*Double(level))) / 3.0 // (1911 - 10*level) / 3
			topMultiplier = Int(floor(dtm))
		} else if 98 < level && level <= 100 {
			divisor = 100
			topMultiplier = 160 - level
		} else {
			return ExperienceCurve.UndefinedExperience
		}
		
		let doub = (pow(Double(level), 3) * Double(topMultiplier)) / Double(divisor)
		// Lossy? Shouldn't be.
		return Int(doub)
	}
	
	private func slowExperienceRequired(_ level:Int) -> Int {
		if 1 <= level && level <= 100 {
			let doub = 5.0 * pow(Double(level), 3) / 4.0
			return Int(doub)
		} else {
			return ExperienceCurve.UndefinedExperience
		}
	}
	
	private func mediumSlowExperienceRequired(_ level:Int) -> Int {
		if 1 <= level && level <= 100 {
			let dFirst = (6.0/5.0) * pow(Double(level),3) // 6/5 * level^3
			let dSecond = 15.0 * pow(Double(level),2) // 15 * level^2
			let dThird = (100.0 * Double(level)) - 140 // 100 * level - 140
			return Int(dFirst - dSecond + dThird)
		} else {
			return ExperienceCurve.UndefinedExperience
		}
	}
	
	private func mediumFastExperienceRequired(_ level:Int) -> Int {
		return Int(pow(Double(level), 3)) // level^3
	}
	
	private func fastExperienceRequired(_ level:Int) -> Int {
		if 1 <= level && level <= 100 {
			let doub = 4.0 * pow(Double(level), 3) / 5.0
			return Int(doub)
		} else {
			return ExperienceCurve.UndefinedExperience
		}
	}
	
	private func fluctuatingExperienceRequired(_ level:Int) -> Int {
		var numerator:Double
		
		if 1 <= level && level <= 15 {
			let expression = (Double(level) + 1.0) / 3.0
			numerator = floor(expression) + 24.0
		} else if 15 < level && level <= 36 {
			numerator = Double(level) + 14.0
		} else if 36 < level && level <= 100 {
			let expression = Double(level) / 2.0
			numerator = floor(expression) + 32.0
		} else {
			return ExperienceCurve.UndefinedExperience
		}
		
		return Int((pow(Double(level), 3) * numerator) / 50.0)
	}
}
