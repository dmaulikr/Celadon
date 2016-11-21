//
//  Monster.swift
//  tbbs
//
//  Created by Jim Boulter on 8/7/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

class Monster {
    
    var id:Int
    var health:Int
    var experience:Int
    var moves:[Int]
	var learnableMoves:[Int]
    var name:String
    
    class func monsterWithId(_ id:Int) -> Monster {
        //query for monster
        return Monster()
    }
    
    init() {
        id = 0
        health = 100
        experience = 69
        moves = [0,1,2,3]
		learnableMoves = [0,1,2,3]
        name = "Monster"
    }
}
