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

struct ActionQueue : Queue {
	private var contents:[Action] = []
	
	mutating func push(_ action:Action) {
		if contents.count == 0 {
			contents.push(action)
			return
		}
		
		// binary search for insertion point for logn insertion
		var high = contents.count
		var low = 0
		var mid = (high - low) / 2 + low
		while mid > low {
			if action >= contents[mid] {
				high = mid
			} else {
				low = mid
			}
			mid = (high - low) / 2 + low
		}
		
		if action < contents[mid] {
			contents.insert(action, at: high)
		} else {
			contents.insert(action, at: mid)
		}
	}
	
	mutating func pop() -> Action? {
		return contents.pop()
	}
	
	var count:Int {
		return contents.count
	}
}
