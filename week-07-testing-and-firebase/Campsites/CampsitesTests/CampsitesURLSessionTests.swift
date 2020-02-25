//
//  CampsitesURLSessionTests.swift
//  CampsitesTests
//
//  Created by Isaac Sheets on 2/24/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import XCTest

class CampsitesURLSessionTests: XCTestCase {
    
    //our system under test is a URL session
    var sut: URLSession!

    override func setUp() {
        super.setUp()
        //init our session
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_ValidCallToNPSGets200Response() {
        //MARK: given
        //make sure you use a valid url
        let url = URL(string: "https://developer.nps.gov/api/v1/campgrounds?stateCode=co&api_key=KuzYWrSKHbuz6CBO8oc0pX35CeljxNSfgxane4IH")
        //we guarantee that the completino handler will be invoked
        let promise = expectation(description: "Completion handler invoked")
        //variables to hold parts of the response we're concerned with
        var statusCode: Int?
        var responseError: Error?

        //MARK: when
        let dataTask = sut.dataTask(with: url!, completionHandler: {data, response, error in
            //simply assign the completionHandler parameters to our variables
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        })
        
        //run the data task
        dataTask.resume()
        //wait for the promis to fulfill or 5 seconds whichever comes first
        wait(for: [promise], timeout: 5)

        //MARK: then
        //make sure we didn't get an error
        XCTAssertNil(responseError)
        //make sure that we got a 200 response back
        XCTAssertEqual(statusCode, 200)
    }

}
