//
//  Continents.swift
//  countries
//
//  Created by Isaac Sheets on 2/2/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

struct ContinentsDataModel: Codable {
    var continent: String
    var countries: [String]
}

enum DataError: Error {
    case NoDataFile
    case CouldNotDecode
}

class ContinentsDataController {
    var allData = [ContinentsDataModel]()
    let fileName = "continents2"
    
    //load data from plist
    func loadData() throws {
        //check for file and get URL if possible
        if let dataURL = Bundle.main.url(forResource: fileName, withExtension: "plist") {
            let decoder = PropertyListDecoder()
            do {
                //get byte buffer (raw data)
                let data = try Data(contentsOf: dataURL)
                //decode to our model
                allData = try decoder.decode([ContinentsDataModel].self, from: data)
            } catch {
                throw DataError.CouldNotDecode
            }
        }
        else {
            //couldn't get path
            throw DataError.NoDataFile
        }
    }
    
    //fetch all the continents
    func getContinents() -> [String] {
        //init empty array
        var allContinents = [String]()
        //loop through data and append to array
        for item in allData {
            allContinents.append(item.continent)
        }
        return allContinents
    }
    
    //get array of countries based on continent
    func getCountries(idx: Int) -> [String] {
        return allData[idx].countries
    }
    
    //add a country
    func addCountry(dataIdx: Int, newCountry: String, countryIdx: Int) {
        allData[dataIdx].countries.insert(newCountry, at: countryIdx)
    }
    
    //delete a country
    func deleteCountry(dataIdx: Int, countryIdx: Int) {
        allData[dataIdx].countries.remove(at: countryIdx)
    }
}
