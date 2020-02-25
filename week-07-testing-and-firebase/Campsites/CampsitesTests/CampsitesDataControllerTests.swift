//
//  CampsitesDataControllerTests.swift
//  CampsitesTests
//
//  Created by Isaac Sheets on 2/24/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import XCTest
//import target
@testable import Campsites

class CampsitesDataControllerTests: XCTestCase {
    
    //define our system under test
    var sut: CampsiteDataController!
    
    override func setUp() {
        super.setUp()
        //init our system under test in set up so it can be destroyed later
        sut = CampsiteDataController()
    }

    override func tearDown() {
        //de-reference sut
        sut = nil
        super.tearDown()
    }
    
    func test_parseJSON() {
        //get access to the bundle for our test target
        let testBundle = Bundle(for: type(of: self))
        //get path of sample json static data file
        let path = testBundle.path(forResource: "sample-campground-response", ofType: "json")
        //load contents of file into byte buffer
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        sut.parseJson(rawData: data!)
        
        XCTAssertEqual(sut.currentCampsites.data.count, 17, "Didn't parse 17 items from fake JSON response")
    }
}
