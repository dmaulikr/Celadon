//
//  Move.swift
//  tbbs
//
//  Created by Jim Boulter on 8/7/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import UIKit

enum Type {
    case fire
    case water
    case grass
    case electric
}

enum TargetType {
    case single
    case team
    case all
}

class Move {

    var id:Int
    var name:String
    var type:Type
    var damage:Int
    var criticalRatio:Float
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
        criticalRatio = 0.01
        targetType = .single
    }
    
    
}
