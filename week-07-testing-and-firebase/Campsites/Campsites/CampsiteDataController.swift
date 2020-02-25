//
//  CampsiteDataController.swift
//  Campsites
//
//  Created by Isaac Sheets on 2/18/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

class CampsiteDataController {
    //stores all of the campsites from the most recent response
    var currentCampsites = CampsiteData()
    //closure to notify the view controller when the json has been loaded and parsed
    var onDataUpdate: ((_ data: [Campsite]) -> Void)?
    
    //URL session property with default intial value, needed for testing
    var session: DHURLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    //makes the http request based on stateCode parameter
    func loadJson(stateCode: String) {
        //construct URL by interpolating the state code into
        let urlPath = "https://developer.nps.gov/api/v1/campgrounds?stateCode=\(stateCode)&api_key=KuzYWrSKHbuz6CBO8oc0pX35CeljxNSfgxane4IH"
        
        //use a guard statement with conditional unwrapping to make sure the url is valid
        guard let url = URL(string: urlPath) else {
            print("bad url")
            return
        }
        
        //valid url so make the request and give it a completetion handler closure
        let dataTask = session.dataTask(with: url, completionHandler: {(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void in
            //downcase to URLResponse since we made and https request
            let httpResponse = response as! HTTPURLResponse
            
            //get the status code
            let statusCode = httpResponse.statusCode
            
            //make sure we got a good response
            guard statusCode == 200 else {
                print("file download error. status code: \(statusCode)")
                return
            }
            //download successful
            print("download complete")
            //parse json asynch
            DispatchQueue.main.async {self.parseJson(rawData: data!)}
        })
        
        //must call resume to run session and execute request
        dataTask.resume()
    }
    
    //parses the raw http response and notifies the view controller
    func parseJson(rawData: Data)  {
        do {
            //try to decode the response
            let parsedData = try JSONDecoder().decode(CampsiteData.self, from: rawData)
            //clear out old data
            currentCampsites.data.removeAll()
            //add all the campsite entries to our class property that stores the current campsites
            for campsite in parsedData.data {
                currentCampsites.data.append(campsite)
            }
        } catch {
            //something went wrong parsing the data — throw error!
            print("json error")
            print(error.localizedDescription)
        }
        print("parsejson done")
        
        //pass data back to requesting object
        onDataUpdate?(currentCampsites.data)
    }
}
