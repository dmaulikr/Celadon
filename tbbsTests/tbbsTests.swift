//
//  tbbsTests.swift
//  tbbsTests
//
//  Created by Jim Boulter on 8/7/16.
//  Copyright © 2016 Jim Boulter. All rights reserved.
//

import XCTest
@testable import tbbs

class tbbsTests: XCTestCase {
    
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
	
	func testSettingMonsterLevelWrong() {
		let m = Monster()
		m.level = 101
		XCTAssert(m.level == 100, "Level set over 100")
		m.level = 0
		XCTAssert(m.level == 1, "Level set under 1")
	}
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
