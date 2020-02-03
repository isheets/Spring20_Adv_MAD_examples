//
//  Continents.swift
//  countries
//
//  Created by Isaac Sheets on 2/2/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

//need to conform to Codable protocol since we'll be encoding and decoding
struct ContinentsDataModel: Codable {
    var continent: String
    var countries: [String]
}

enum DataError: Error {
    case NoDataFile
    case CouldNotDecode
    case CouldNotEncode
}

class ContinentsDataController {
    var allData = [ContinentsDataModel]()
    let fileName = "continents2"
    let dataFileName = "data.plist"
    
    //load data from plist
    func loadData() throws {
        let pathURL: URL?
        
        //get the path where our data file would be
        let dataFileURL = getDataFile(datafile: dataFileName)
        
        //check to see if the data file exists
        if FileManager.default.fileExists(atPath: dataFileURL.path) {
            pathURL = dataFileURL
        } else {
            //load default data if we can't find a user data file
            pathURL = Bundle.main.url(forResource: fileName, withExtension: "plist")
            
        }

        //check for file and get URL if possible
        if let dataURL = pathURL {
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
    
    func getDataFile(datafile: String) -> URL {
        //get path for data file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //documents directory
        
        // URL for our plist
        return docDir.appendingPathComponent(datafile)
    }

    
    func writeData() throws {
        let dataFileURL = getDataFile(datafile: dataFileName)
        //get an encoder
        let encoder = PropertyListEncoder()
        //set format — plist is a type of xml
        encoder.outputFormat = .xml
        do {
            let data = try encoder.encode(allData.self)
            try data.write(to: dataFileURL)
        } catch {
            print(error)
            throw DataError.CouldNotEncode
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
