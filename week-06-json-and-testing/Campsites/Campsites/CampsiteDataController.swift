//
//  CampsiteDataController.swift
//  Campsites
//
//  Created by Isaac Sheets on 2/18/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

enum JsonError: Error {
    case BadURL
    case BadResponse
    case CouldNotParse
}

class CampsiteDataController {
    
    func loadJson(stateCode: String) throws -> [Campsite] {
        //construct URL by interpolating the state code into
        let urlPath = "https://developer.nps.gov/api/v1/campgrounds?stateCode=\(stateCode)&api_key=KuzYWrSKHbuz6CBO8oc0pX35CeljxNSfgxane4IH"
        
        //use a guard statement with conditional unwrapping to make sure the url is valid
        guard let url = URL(string: urlPath) else {
            print("url error")
            throw JsonError.BadURL
        }
        
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard statusCode == 200 else {
                    print("file download error")
                    return
            }
            //download successful
            print("download complete")
            //parse json
            parseJson(rawData: data!)
        })
        //must call resume to run session
        session.resume()
    }
    
    func parseJson(rawData: Data) -> [Campsite] {
        
    }
    
    func getResults() {
        
    }
}
