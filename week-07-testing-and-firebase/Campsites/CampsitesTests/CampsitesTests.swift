//
//  CampsitesTests.swift
//  CampsitesTests
//
//  Created by Isaac Sheets on 2/23/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import XCTest
//import the Campsites module for testing
@testable import Campsites

enum ResponseError: Error {
    case BadResponse
}

class CampsitesTests: XCTestCase {
    var sut: CampsiteDataController!
    var data: Data!
    var url: URL?
    var promise: XCTestExpectation!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = CampsiteDataController()
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "sample-campground-response", ofType: "json")
        data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)

        url =
          URL(string: "https://developer.nps.gov/api/v1/campgrounds?stateCode=co&api_key=KuzYWrSKHbuz6CBO8oc0pX35CeljxNSfgxane4IH")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func test_parseJson_invalid_response() {
        // given
        promise = expectation(description: "Status code: 404")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 404, httpVersion: nil, headerFields: nil)
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: ResponseError.BadResponse)
        sut.session = sessionMock
        sut.onDataUpdate = {[weak self] (data:[Campsite]) in self?.promise.fulfill()}

        // when
        XCTAssertEqual(sut.currentCampsites.data.count, 0, "currentCampsites should be empty before the data task runs")

        let url = URL(string: "https://developer.nps.gov/api/v1/campgrounds?stateCode=co&api_key=KuzYWrSKHbuz6CBO8oc0pX35CeljxNSfgxane4IH")
        
        let dataTask = sut.session.dataTask(with: url!, completionHandler: sut.responseHandler)

        dataTask.resume()
        wait(for: [promise], timeout: 5)

        // then
        XCTAssertEqual(sut.currentCampsites.data.count, 0, "Didn't parse 17 items from fake JSON response")
    }
    
    func test_parseJson_valid_response() {
        // given
        promise = expectation(description: "Status code: 200")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        sut.session = sessionMock

        sut.onDataUpdate = {[weak self] (data:[Campsite]) in self?.promise.fulfill()}

        // when
        XCTAssertEqual(sut.currentCampsites.data.count, 0, "currentCampsites should be empty before the data task runs")

        let url = URL(string: "https://developer.nps.gov/api/v1/campgrounds?stateCode=co&api_key=KuzYWrSKHbuz6CBO8oc0pX35CeljxNSfgxane4IH")
        let dataTask = sut.session.dataTask(with: url!, completionHandler: sut.responseHandler)

        dataTask.resume()
        wait(for: [promise], timeout: 5)

        // then
        XCTAssertEqual(sut.currentCampsites.data.count, 17, "Didn't parse 17 items from fake JSON response")
    }
}
