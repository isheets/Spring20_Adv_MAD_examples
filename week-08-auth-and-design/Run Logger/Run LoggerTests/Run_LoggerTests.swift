//
//  Run_LoggerTests.swift
//  Run LoggerTests
//
//  Created by Isaac Sheets on 3/4/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import XCTest
@testable import Run_Logger

class Run_LoggerTests: XCTestCase {
    
    var sut:Run!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Run(title: "Test", date: Date(), miles: 3.1, duration: (21 * 60), notes: "5k run")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getPace() {
        let pace = sut.getPace()
        XCTAssertEqual(6.77, pace, "3 miles in 21 min did not output 7:00min/mi pace")
    }

}
