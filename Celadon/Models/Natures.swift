//
//  Natures.swift
//  Celadon
//
//  Created by Jim Boulter on 11/30/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

enum Nature : NatureEffect {
    case hardy, docile, bashful, quirky = "-1,-1"
    case lonely = "1,2"
    case brave = "1,5"
    case adamant = "1,3"
    case naughty = "1,4"
    case bold = "2,1"
    case relaxed = "2,5"
    case impish = "2,3"
    case lax = "2,4"
    case timid = "5,1"
    case hasty = "5,2"
    case jolly = "5,3"
    case naive = "5,4"
    case modest = "3,1"
    case mild = "3,2"
    case quiet = "3,5"
    case rash = "3,4"
    case calm = "4,1"
    case gentle = "4,2"
    case sassy = "4,5"
    case careful = "4,3"

	func multiplierFor(_ stat:Stat) -> Float {
		return self.rawValue.multiplierFor(stat)
	}
}

struct NatureEffect : ExpressibleByStringLiteral, Equatable {
	
	typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
	typealias UnicodeScalarLiteralType = Character
	
	var increasedStat:Stat? = nil
	var decreasedStat:Stat? = nil
	
	/// Creates an instance initialized to the given string value.
	init(stringLiteral value: StringLiteralType) {
		self.init(string:value)
	}
	
	init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
		self.init(string:"\(value)")
	}
	
	init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
		self.init(string:value)
	}
	
	init(string:String) {
		let arr = string.components(separatedBy:",")
		let arrOfInts = arr.map{ Int($0) }
		if let inc:Int = arrOfInts[0], let dec:Int = arrOfInts[1] {
			self.init(Stat(rawValue:inc), Stat(rawValue:dec))
		} else {
			self.init(nil, nil)
		}
	}
	
    init(_ increased:Stat? = nil, _ decreased:Stat? = nil) {
        increasedStat = increased
        decreasedStat = decreased
    }
	
	func multiplierFor(_ stat:Stat) -> Float {
		if self.increasedStat == stat {
			// 10% increase
			return 1.1
		} else if self.decreasedStat == stat {
			// 10% decrease
			return 0.9
		} else {
			// No multipler, use identity
			return 1
		}
	}
    
    static func convertFromStringLiteral(value:String) -> NatureEffect {
        return NatureEffect(stringLiteral: value)
    }
    
    func stringValue() -> String {
        return "\(increasedStat),\(decreasedStat)"
    }
	
	static func ==(_ lhs:NatureEffect, _ rhs:NatureEffect) -> Bool {
		return lhs.increasedStat == rhs.increasedStat && lhs.decreasedStat == rhs.decreasedStat
	}
    
    // Has to do with poffins and stuff
    // Do much later
    //var favoriteFlavor:Flavor
    //var dislikedFlavor:Flavor
}
