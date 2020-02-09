//
//  Continents.swift
//  countries_demo
//
//  Created by Isaac Sheets on 2/6/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

//data model based on plist
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
    let filename = "continents2"
    
    func loadData() throws {
        if let dataURL = Bundle.main.url(forResource: filename, withExtension: "plist") {
            
            let decoder = PropertyListDecoder()
            
            do {
                let data = try Data(contentsOf: dataURL)
                allData = try decoder.decode([ContinentsDataModel].self, from: data)
            } catch {
                throw DataError.CouldNotDecode
            }
            
        } else {
            throw DataError.NoDataFile
        }
    }
    
    func getContinents() -> [String] {
        
        var allContinents = [String]()
        
        for item in allData {
            allContinents.append(item.continent)
        }
        
        return allContinents
    }
    
    func getCountries(idx: Int) -> [String] {
        return allData[idx].countries
    }
    
    func addCountry(dataIdx: Int, newCountry: String, countryIdx: Int) {
        allData[dataIdx].countries.insert(newCountry, at: countryIdx)
        
    }
    
    func deleteCountry(dataIdx: Int, countryIdx: Int) {
        allData[dataIdx].countries.remove(at: countryIdx)
    }
}
