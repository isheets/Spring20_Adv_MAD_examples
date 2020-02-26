//
//  CampsitesDataControllerTests.swift
//  CampsitesTests
//
//  Created by Isaac Sheets on 2/25/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import XCTest
@testable import Campsites

class CampsitesDataControllerTests: XCTestCase {
    
    var sut: CampsiteDataController!

    override func setUp() {
        super.setUp()
        sut = CampsiteDataController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_parseJsonValidData() {
        //MARK: given
        //get access to test bundle
        let testBundle = Bundle(for: type(of: self))
        //get path of json
        let path = testBundle.path(forResource: "sample-campground-response", ofType: "json")
        //load data
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        //MARK: when
        sut.parseJson(rawData: data!)
        
        //MARK: given
        XCTAssertEqual(sut.currentCampsites.data.count, 17, "Didn't parse 17 campsites from the fake JSON")
    }

}
