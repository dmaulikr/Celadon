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
}

enum TargetType {
    case single
    case team
    case all
	case single_self
}

class Move {

    var id:Int
    var name:String
    var type:Type
    var damage:Int
    var criticalRatio:Float
	var accuracy:Int
    var targetType:TargetType
    
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
    }
    
    
}
