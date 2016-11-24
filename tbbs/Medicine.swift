//
//  Medicine.swift
//  tbbs
//
//  Created by Jim Boulter on 11/24/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

struct Affectivity : OptionSet {
	let rawValue: Int
	
	static let paralysis = Affectivity(rawValue: 1 << 0)
	static let sleep = Affectivity(rawValue: 1 << 1)
	static let poison  = Affectivity(rawValue: 1 << 2)
}

class Medicine : Item {
	
	var affectivity:Affectivity
	
	override init() {
		affectivity = []
		
		super.init()
		itemType = .consumable
	}
	
}
