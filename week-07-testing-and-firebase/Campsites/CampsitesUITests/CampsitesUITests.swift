//
//  CampsitesUITests.swift
//  CampsitesUITests
//
//  Created by Isaac Sheets on 2/23/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import XCTest

class CampsitesUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_labels() {
        
        let app = XCUIApplication()
        let picker = app.pickerWheels.element
        let button = app.buttons.element
        picker.adjust(toPickerWheelValue: "CA")
        print(picker.value)
        print(button.staticTexts)
        XCTAssertTrue(button.label == "Search in CA")
    }
}
