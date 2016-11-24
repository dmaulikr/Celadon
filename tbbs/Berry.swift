//
//  Berry.swift
//  tbbs
//
//  Created by Jim Boulter on 11/22/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import Foundation

enum BerryType {
	case healing
	case status
	case food
}

class Berry:Item {
	var berryType:BerryType
	
	override init() {
		berryType = .healing
		
		super.init()
	}
}
