//
//  Action.swift
//  tbbs
//
//  Created by Jim Boulter on 11/24/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

enum ActionType : Int {
	case move = 0 // lowest priority
	case item = 1
	case rotate = 2 // highest priority
	
	static func max() -> ActionType {
		return .rotate
	}
}

struct Action {
	// all
	var actionType:ActionType
	var user:Monster
	
	// move
	var move:Move? = nil
	
	// item
	var item:Item? = nil
	
	// rotate
	var target:Monster? = nil
	
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
		actionType = .rotate
		
		user = rotatingMonster
		target = forMonster
	}
	
	var calculatedMovePriority:Float? {
		if move != nil {
			// TODO Properly calculate this value
			let targetSpeed = target.speed ?? 0.0
			if let targetMonster = target {
				
			}
			return move!.priority + Float(user.speed - targetSpeed)
		}
		return nil
	}
}
