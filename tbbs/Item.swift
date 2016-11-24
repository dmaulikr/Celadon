//
//  Item.swift
//  tbbs
//
//  Created by Jim Boulter on 11/22/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

enum ItemType {
	case consumable
	case key // key item
	case held
}

enum StatusCondition {
	case paralysis
	case sleep
	case poison
}

enum SpecialConditions {
	case confusion
}

protocol heals {
	var healValue:Int { get }
}

protocol cures {
	var effects:[StatusEffect] { get }
}

class Item {
	var itemType:ItemType
	
	init() {
		itemType = .consumable
	}
}
