//
//  Move.swift
//  tbbs
//
//  Created by Jim Boulter on 8/7/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

enum Type {
    case fire
    case water
    case grass
    case electric
	case dark
	case flying
	case bug
	case dragon
	case ice
	case fairy
	case ground
	case rock
	case steel
	case normal
	case fighting
	case ghost
	case psychic
	case poison
}

enum TargetType {
    case single
    case team
    case all
	case single_self
	case single_ally
	case team_ally
}

enum DamageType {
	case physical
	case special
	case status
}

class Move {
	
	// Map of effectiveness for move type to defender type, multipliers can be combined for multi-type monsters
	static private let effectivenessMap:[Type:[Type:Float]] =
		[	.fire		: [.fire:0.5, .water:0.5, .grass:2.0, .ice:2.0, .bug:2.0, .rock:0.5, .dragon:0.5, .steel:2.0],
		 	.water		: [.fire:2.0, .water:0.5, .grass:0.5, .ground:2.0, .rock:2.0, .dragon:0.5],
		 	.grass		: [.fire:0.5, .water:2.0, .grass:0.5, .poison:0.5, .ground:2.0, .flying:0.5, .bug:0.5, .rock:2.0, .dragon:0.5, .steel:0.5],
		 	.electric	: [.water:2.0, .grass:0.5, .electric:0.5, .ground:0.0, .flying:2.0, .dragon:0.5],
		 	.dark		: [.fighting:0.5, .psychic:2.0, .ghost:2.0, .dark:0.5, .fairy:0.5],
		 	.flying		: [.grass:2.0, .electric:0.5, .fighting:2.0, .bug:2.0, .rock:0.5, .steel:0.5],
		 	.bug		: [.fire:0.5, .grass:2.0, .fighting:0.5, .poison:0.5, .flying:0.5, .psychic:2.0, .ghost:0.5, .dark:2.0, .steel:0.5, .fairy:0.5],
		 	.dragon		: [.dragon:2.0, .steel:0.5, .fairy:0.0],
		 	.ice		: [.fire:0.5, .water:0.5, .grass:2.0, .ice:0.5, .ground:2.0, .flying:2.0, .dragon:2.0, .steel:0.5],
		 	.fairy		: [.fire:0.5, .fighting:2.0, .poison:0.5, .dragon:2.0, .dark:2.0, .steel:0.5],
		 	.ground		: [.fire:2.0, .grass:0.5, .electric:2.0, .poison:2.0, .flying:0, .bug:0.5, .rock:2.0, .steel:2.0],
		 	.rock		: [.fire:2.0, .ice:2.0, .fighting:0.5, .ground:0.5, .flying:2.0, .bug:2.0, .steel:0.5],
		 	.steel		: [.fire:0.5, .water:0.5, .electric:0.5, .ice:2.0, .psychic:2.0, .steel:0.5, .fairy:2.0],
		 	.normal		: [.rock:0.5, .ghost:0.0, .steel:0.5],
		 	.fighting	: [.normal:2.0, .ice:2.0, .poison:0.5, .flying:0.5, .psychic:0.5, .bug:0.5, .rock:2.0, .ghost:0.0, .dark:2.0, .steel:2.0, .fairy:0.5],
		 	.ghost		: [.normal:0.0, .psychic:2.0, .ghost:2.0, .dark:0.5],
		 	.psychic	: [.fighting:2.0, .poison:2.0, .psychic:0.5, .dark:0.0, .steel:0.5],
		 	.poison		: [.grass:2.0, .poison:0.5, .ground:0.5, .rock:0.5, .ghost:0.5, .steel:0.0, .fairy:2.0]
	]
	
    var id:Int
    var name:String
    var type:Type
    var damage:Int
    var criticalRatio:Float
	var accuracy:Int
    var targetType:TargetType
	var priority:Int
	var damageType:DamageType
	
    class func moveWithId(_ id:Int) -> Move {
        //query for move
        return Move()
    }
    
    init() {
        id = 0
        name = "Tackle"
        type = .fire
        damage = 100
        criticalRatio = 0.065
		accuracy = 100
        targetType = .single
		priority = 1
		damageType = .physical
    }
    
	func effectiveness(against:Monster) -> Float {
		var mul:Float = 1.0
		for type in against.types {
			if let tmul = Move.effectivenessMap[self.type]?[type] {
				mul *= tmul
			}
		}
		return mul
	}
}
