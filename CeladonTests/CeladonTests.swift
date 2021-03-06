//
//  CeladonTests.swift
//  CeladonTests
//
//  Created by Jim Boulter on 8/7/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import XCTest
@testable import Celadon

class CeladonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
	
	func testExperienceCurves() {
		var experienceCurve = ExperienceCurve.slow
		
		experienceCurve = .slow
		XCTAssert(experienceCurve.experienceRequired(100) == 1250000)
		XCTAssert(experienceCurve.experienceRequired(90, 100) == 338750)
		XCTAssert(experienceCurve.experienceRequired(10) == 1250)
		
		experienceCurve = .medium_slow
		XCTAssert(experienceCurve.experienceRequired(100) == 1059860)
		XCTAssert(experienceCurve.experienceRequired(10) == 560)
		
		experienceCurve = .medium_fast
		XCTAssert(experienceCurve.experienceRequired(100) == 1000000)
		
		experienceCurve = .fast
		XCTAssert(experienceCurve.experienceRequired(100) == 800000)
		XCTAssert(experienceCurve.experienceRequired(90,100) == 216800)
		
		experienceCurve = .erratic
		XCTAssert(experienceCurve.experienceRequired(100) == 600000)
		XCTAssert(experienceCurve.experienceRequired(10) == 1800)
		XCTAssert(experienceCurve.experienceRequired(90,100) == 108654)
		
		experienceCurve = .fluctuating
		XCTAssert(experienceCurve.experienceRequired(100) == 1640000)
		XCTAssert(experienceCurve.experienceRequired(10) == 540)
		XCTAssert(experienceCurve.experienceRequired(90, 100) == 517340)
	}
	
	func testAwardingExperienceWithLevelUp() {
		let m = Monster()
		let lv = m.level
		m.awardExperience(m.experienceRequiredToLevel)
		XCTAssert(lv+1 == m.level, "Did not level up correctly on experience award")
	}
	
	func testExperienceCurveLevelSolve() {
		let ec = ExperienceCurve.slow
		XCTAssert(ec.level(1250000) == 100)
		XCTAssert(ec.level(800000) == 86)
		XCTAssert(ec.level(1) == 1)
		XCTAssert(ec.level(10) == 2)
		XCTAssert(ec.level(100) == 4)
		XCTAssert(ec.level(156250) == 50)
		XCTAssert(ec.level(156249) == 49)
	}
	
	func testActionQueueTypePriority() {
		var q = ActionQueue()
		q.push(Action(Medicine(), Monster()))
		q.push(Action(Monster(), Monster()))
		q.push(Action(Move(), Monster()))
		
		XCTAssert(q.pop()?.actionType == .shift)
		XCTAssert(q.pop()?.actionType == .item)
		XCTAssert(q.pop()?.actionType == .move)
	}
	
	func testMoveEffectiveness() {
		let mv = Move()
		mv.type = .fire
		let mon = Monster()
		mon.types = [.normal]
		XCTAssert(mv.effectiveness(against: mon) == 1.0)
		mon.types = [.water]
		XCTAssert(mv.effectiveness(against: mon) == 1.0/2.0)
		mon.types = [.water, .ground]
		XCTAssert(mv.effectiveness(against: mon) == 1.0/2.0)
		mon.types = [.water, .rock]
		XCTAssert(mv.effectiveness(against: mon) == 1.0/4.0)
		
		mv.type = .fighting
		mon.types = [.normal, .ghost]
		XCTAssert(mv.effectiveness(against: mon) == 0.0)
		
	}
	
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
