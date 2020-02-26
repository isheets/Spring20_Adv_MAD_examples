//
//  CampsitesTests.swift
//  CampsitesTests
//
//  Created by Isaac Sheets on 2/25/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import XCTest

class CampsitesTests: XCTestCase {
    
    //system under test
    var sut : URLSession!

    override func setUp() {
        super.setUp()
        //default instance of URLSession
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ValidCallToNPSGets200Response() {
        //MARK: given
        let promise = expectation(description: "Completion handler invoked")
        let url = URL(string: "https://developer.nps.gov/api/v1/campgrounds?stateCode=CO&api_key=KuzYWrSKHbuz6CBO8oc0pX35CeljxNSfgxane4IH")
        var statusCode: Int?
        var responseError: Error?
    
        //MARK: when
        let dataTask = sut.dataTask(with: url!, completionHandler: {data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        })
        
        //execute data task
        dataTask.resume()
        wait(for: [promise], timeout: 10)
        
        //MARK: then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200, "Response not 200")
    }
}
