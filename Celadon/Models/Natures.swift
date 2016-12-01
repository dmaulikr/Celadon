//
//  Natures.swift
//  Celadon
//
//  Created by Jim Boulter on 11/30/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

struct Nature : Equatable {

	static let hardy =		Nature(nil,nil,"hardy")
	static let docile =		Nature(nil,nil,"docile")
	static let bashful =	Nature(nil,nil,"bashful")
	static let quirky =		Nature(nil,nil,"quirky")
    static let lonely =		Nature(.attack,.defense,"lonely")
    static let brave =		Nature(.attack,.speed,"brave")
    static let adamant =	Nature(.attack,.specialAttack,"adamant")
    static let naughty =	Nature(.attack,.specialDefense,"naughty")
    static let bold =		Nature(.defense,.attack,"bold")
    static let relaxed =	Nature(.defense,.speed,"relaxed")
    static let impish =		Nature(.defense,.specialAttack,"impish")
    static let lax =		Nature(.defense,.specialDefense,"lax")
    static let timid =		Nature(.speed,.attack,"timid")
    static let hasty =		Nature(.speed,.defense,"hasty")
    static let jolly =		Nature(.speed,.specialAttack,"jolly")
    static let naive =		Nature(.speed,.specialDefense,"naive")
    static let modest =		Nature(.specialAttack,.attack,"modest")
    static let mild =		Nature(.specialAttack,.defense,"mild")
    static let quiet =		Nature(.specialAttack,.speed,"quiet")
    static let rash =		Nature(.specialAttack,.specialDefense,"rash")
    static let calm =		Nature(.specialDefense,.attack,"calm")
    static let gentle =		Nature(.specialDefense,.defense,"gentle")
    static let sassy =		Nature(.specialDefense,.speed,"sassy")
    static let careful =	Nature(.specialDefense,.specialAttack,"careful")
	
	var increasedStat:Stat? = nil
	var decreasedStat:Stat? = nil
	var name:String = "hardy"

	init(_ increased:Stat? = nil, _ decreased:Stat? = nil, _ _name:String) {
		increasedStat = increased
		decreasedStat = decreased
		name = _name
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
	
	static func ==(_ lhs:Nature, _ rhs:Nature) -> Bool {
		return lhs.increasedStat == rhs.increasedStat && lhs.decreasedStat == rhs.decreasedStat
	}
}
