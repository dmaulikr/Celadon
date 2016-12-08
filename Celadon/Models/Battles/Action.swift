//
//  Action.swift
//  Celadon
//
//  Created by Jim Boulter on 11/24/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

enum ActionType : Int {
	case move = 4
	case item = 3
	case shift = 2
	case escape = 1
	case megaEvolve = 0
	
	static func max() -> ActionType {
		return .move
	}
}

struct Action : Comparable {
	// all
	var actionType:ActionType
	var user:Monster
	
	// move
	var move:Move? = nil
	
	// item
	var item:Item? = nil
	
	// switch and move
	var target:Monster? = nil
	
	static func <(_ lhs:Action, _ rhs:Action) -> Bool {
		if lhs.priority == rhs.priority {
			return lhs.user.speed < rhs.user.speed
		}
		return lhs.priority < rhs.priority
	}
	
	static func >(_ lhs:Action, _ rhs:Action) -> Bool {
		if lhs.priority == rhs.priority {
			return lhs.user.speed > rhs.user.speed
		}
		return lhs.priority > rhs.priority
	}
	
	static func ==(_ lhs:Action, _ rhs:Action) -> Bool {
		return lhs.priority == rhs.priority && lhs.user.speed == rhs.user.speed
	}
	
	init(_ move:Move, _ usedBy:Monster) {
		actionType = .move
		
		self.move = move
		user = usedBy
	}
	
	init(_ item:Item, _ onMonster:Monster) {
		actionType = .item
		
		self.item = item
		user = onMonster
	}
	
	init(_ rotatingMonster:Monster, _ forMonster:Monster) {
		actionType = .shift
		
		user = rotatingMonster
		target = forMonster
	}
	
	var priority:Int {
		if let mv = move {
			return mv.priority
		} else if actionType == .megaEvolve {
			return 7
		} else { // everything else
			return 8
		}
	}
}
