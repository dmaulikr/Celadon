//
//  ActionQueue.swift
//  tbbs
//
//  Created by Jim Boulter on 11/24/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

protocol Queue {
	mutating func push(_ action:Action)
	mutating func pop() -> Action?
	var count:Int { get }
}

extension Array : Queue { // Non priority queue interface for arrays
	mutating func pop() -> Action? {
		if let ret = self.popElement() as? Action? {
			return ret
		} else {
			return nil
		}
	}

	mutating func push(_ action: Action) {
		if let element = action as? Element {
			self.pushElement(element)
		}
	}

	mutating func pushElement(_ element:Element) {
		self.append(element)
	}
	
	mutating func popElement() -> Element? {
		if let ret = self.first {
			self.remove(at: 0)
			return ret
		} else {
			return nil
		}
	}
}

struct MoveQueue : Queue {
	private var contents:[Action] = []
	
	mutating func push(_ action:Action) {
		var didInsert = false
		for i in 0..<contents.count {
			let comp = contents[i]
			if let cp = comp.calculatedMovePriority,
			   let ap = action.calculatedMovePriority {
				if cp < ap {
					didInsert = true
					contents.insert(action, at: i)
				}
			} else {
				// error: bahavior undefined
				print("You can't just insert a non-move into a move queue and not expect me to be pissed.")
			}
		}
		if !didInsert {
			contents.append(action)
		}
	}
	
	mutating func pop() -> Action? {
		return contents.pop()
	}
	
	var count:Int {
		return contents.count
	}
}

struct ActionQueue : Queue {
	private var contents:[Queue]
	
	init() {
		self.contents = []
		for i in 0...ActionType.max().rawValue {
			if i == ActionType.move.rawValue {
				contents.append(MoveQueue())
			} else {
				contents.append([Action]())
			}
		}
	}
	
	mutating func push(_ action:Action) {
		contents[action.actionType.rawValue].push(action)
	}
	
	mutating func pop() -> Action? {
		for var subqueue in contents {
			return subqueue.pop()
		}
		return nil
	}
	
	var count:Int {
		var count = 0
		for subqueue in contents {
			count += subqueue.count
		}
		return count
	}
}
