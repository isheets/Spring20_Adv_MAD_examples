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
    
    func test_parseMockJson() {
        //MARK: GIVEN
        let promise = expectation(description: "Json parsed")
        //get access to the bundle for our test target
        let testBundle = Bundle(for: type(of: self))
        //get path of sample json static data file
        let path = testBundle.path(forResource: "sample-campground-response", ofType: "json")
        //load contents of file into byte buffer
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        //set the url
        let url = URL(string: "https://developer.nps.gov/api/v1/campgrounds?stateCode=co&api_key=KuzYWrSKHbuz6CBO8oc0pX35CeljxNSfgxane4IH")
        //create a dummy response to inject into our session
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        //create a dummy HTTPSession
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        //set the session to use in our model
        sut.session = sessionMock
        //fulfill our promise when the json has been parsed
        sut.onDataUpdate = {(data:[Campsite]) in promise.fulfill()}

        //MARK: WHEN
        XCTAssertEqual(sut.currentCampsites.data.count, 0, "currentCampsites should be empty before the data task runs")
        
        //set the completion handler and url for the data task
        let dataTask = sut.session.dataTask(with: url!, completionHandler: {(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void in
            //we know the response was valid since it isn't real and its not what we're testing
            //just parse json asynch
            DispatchQueue.main.async {self.sut.parseJson(rawData: data!)}
        })
        
        //execute the fake data task
        dataTask.resume()
        
        //wait for the json to finish parsing
        wait(for: [promise], timeout: 5)
        
        //MARK: THEN
        //make sure we parsed the right amount of campsites
        XCTAssertEqual(sut.currentCampsites.data.count, 17, "Didn't parse 17 items from fake JSON response")
    }
}
