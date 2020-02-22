//
//  CampsiteDataController.swift
//  campsites_demo
//
//  Created by Isaac Sheets on 2/20/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

class CampsiteDataController {
    //current campsites
    var currentCampsites = CampsiteData()
    //closure to notify view controller
    var onDataUpdate: ((_ data: [Campsite]) -> Void)?
    
    func loadJson(stateCode: String) {
        let urlPath = "https://developer.nps.gov/api/v1/campgrounds?stateCode=\(stateCode)&api_key=KuzYWrSKHbuz6CBO8oc0pX35CeljxNSfgxane4IH"
        
        //check url validity
        guard let url = URL(string: urlPath) else {
            //invalid
            print("bad url")
            return
        }
        //valid url
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            
            let statusCode = httpResponse.statusCode
            
            //check response status
            guard statusCode == 200 else {
                print("file download error: \(statusCode)")
                return
            }
            
            print("download complete!")
            
            DispatchQueue.main.async {
                self.parseJson(rawData: data!)
            }
        })
        //make the request
        session.resume()
    }
    
    //parse response and notify view controller
    func parseJson(rawData: Data) {
        do {
            //decode
            let parsedData = try JSONDecoder().decode(CampsiteData.self, from: rawData)
            //clear the current data
            currentCampsites.data.removeAll()
            
            for campsite in parsedData.data {
                currentCampsites.data.append(campsite)
            }
        } catch {
            print("json parsing error")
        }
        print("json parsed successfully!")
        
        onDataUpdate?(currentCampsites.data)
    }
}
