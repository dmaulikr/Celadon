//
//  Battle.swift
//  tbbs
//
//  Created by Jim Boulter on 8/7/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

enum TerrainType {
    case mountain
    case plains
    case island
    case swamp
    case forest
}

struct WeatherType : OptionSet {
    let rawValue: Int
    
    static let clear		= WeatherType(rawValue: 0)
    static let sunny		= WeatherType(rawValue: 1 << 0)
    static let rainy		= WeatherType(rawValue: 1 << 1)
    static let sandstorm	= WeatherType(rawValue: 1 << 2)
    static let pollen		= WeatherType(rawValue: 1 << 3)
    static let miasma		= WeatherType(rawValue: 1 << 4)
}

protocol BattleDelegate {
	
	// battle start / end
	func battleWillStart(_ battle:Battle)
//	func battleDidStart(_ battle:Battle)
	
	// monsters entering / exiting
	func monsterWillExitBattle(_ monster:Monster, _ battle:Battle)
	func monsterDidExitBattle(_ monster:Monster, _ battle:Battle)
	func monsterWillEnterBattle(_ monster:Monster, _ battle:Battle)
	func monsterDidEnterBattle(_ monster:Monster, _ battle:Battle)
	
	func monsterDidFeint(_ monster:Monster)
	
	// turn start / end
	func turnWillStartForBattle(_ battle:Battle)
	func turnWillEndForBattle(_ battle:Battle)

	// use move
	func monsterWillUseMove(_ monster:Monster, _ move:Move, _ battle:Battle)
	func monsterDidUseMove(_ monster:Monster, _ move:Move, _ battle:Battle)
	
	// actions
	func actionWillOccur(_ action:Action)
	func actionDidOccur(_ action:Action)
}

class Battle {

    var teams:[[Monster]]
    var terrain:TerrainType
    var weather:WeatherType
	var delegate:BattleDelegate?
	
	var turnCount:Int
	
	private var actionQueue:ActionQueue
    
	init(teams:[[Monster]], terrain:TerrainType = .plains, weather:WeatherType = .clear, delegate:BattleDelegate? = nil) {
        self.teams = teams
        self.terrain = terrain
        self.weather = weather
		self.delegate = delegate
		
		self.actionQueue = ActionQueue()
		self.turnCount = 0
    }
	
	func resume() {
		if turnCount == 0 {
			delegate?.battleWillStart(self)
		}
		
		while actionQueue.count > 0 {
			executeNextAction()
		}
	}
	
	func executeNextAction() {
		if let next = actionQueue.pop() {
			
			switch next.actionType {
			case .move:
				executeMoveAction()
			case .item:
				executeItemAction()
			case .rotate:
				executeRotateAction()
			}
			
			turnCount += 1
		}
	}
	
	func executeMoveAction() {
		
	}
	
	func executeItemAction() {
		
	}
	
	func executeRotateAction() {
		
	}
}
