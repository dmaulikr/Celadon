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

struct StatModifier {
	var modifier:Int {
		didSet {
			if modifier > 6 {
				modifier = 6
			} else if modifier < -6 {
				modifier = -6
			}
		}
	}
	
	mutating func modify(_ delta:Int) {
		var adjustedDelta = delta
		if delta < -3 {
			print("Cannot lower stat modifier by less than -3")
			adjustedDelta = -3
		} else if delta > 3 {
			print("Cannot rise stat modifier by more than 3")
			adjustedDelta = 3
		}
		
		modifier += adjustedDelta
	}
}

struct StatModifiers {
	var attack:StatModifier
	var defense:StatModifier
	var specialAttack:StatModifier
	var specialDefense:StatModifier
	var speed:StatModifier
	var evasion:StatModifier
}

class Battle {

    var teams:[[Monster]]
    var terrain:TerrainType
    var weather:WeatherType
	var delegate:BattleDelegate?
	
	var monsterStatModifiers:[Monster:StatModifiers] = [:]
	
	var turnCount:Int = 0
	
	private var actionQueue:ActionQueue = ActionQueue()
    
	init(teams:[[Monster]], terrain:TerrainType = .plains, weather:WeatherType = .clear, delegate:BattleDelegate? = nil) {
        self.teams = teams
        self.terrain = terrain
        self.weather = weather
		self.delegate = delegate
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
