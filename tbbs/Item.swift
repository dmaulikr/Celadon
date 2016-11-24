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

protocol Heals {
	var healValue:Int { get }
}

protocol Cures {
	var affectivity:Affectivity { get }
}

protocol Item {
	var itemType:ItemType { get set }
}
