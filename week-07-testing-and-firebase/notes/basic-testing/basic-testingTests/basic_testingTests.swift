//
//  basic_testingTests.swift
//  basic-testingTests
//
//  Created by Isaac Sheets on 2/24/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import XCTest
@testable import basic_testing

class basic_testingTests: XCTestCase {
    
    var sut : FunMath!
    
    override func setUp() {
        sut = FunMath()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_add() {
        //given
        let n1 = 2
        let n2 = 2
        //when
        let result = sut.add(n1: n1, n2: n2)
        //then
        XCTAssertEqual(result, 4, "Incorrectly added 2 + 2")
    }
    
    func test_divideValid() {
        //given
        let dividend = 10
        let divisor = 2
        //when
        let result = sut.divide(dividend: Double(dividend), divisor: Double(divisor))
        //then
        XCTAssertEqual(result, 5.0, "10 divided by 2 did not return 5.0")
    }
    
    func test_divideInvalid() {
        //given
        let dividend = 10.0
        let divisor = 0.0
        //when
        let result = sut.divide(dividend: Double(dividend), divisor: Double(divisor))
        //then
        XCTAssertNil(result, "10 divided by 0 did not return nil")
    }

}
