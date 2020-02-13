//
//  Continents.swift
//  countries_demo
//
//  Created by Isaac Sheets on 2/6/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation
import UIKit

//data model based on plist
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
    let filename = "continents2"
    let dataFileName = "data.plist"
    
    init() {
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(ContinentsDataController.writeData(_:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    
    func getDataFile(dataFile: String) -> URL {
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let docDir = dirPath[0]
        
        return docDir.appendingPathComponent(dataFile)
    }
    
    @objc func writeData(_ notification: NSNotification) throws {
        let dataFileURL = getDataFile(dataFile: dataFileName)
        
        let encoder = PropertyListEncoder()
        
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(allData.self)
            try data.write(to: dataFileURL)
            
        } catch {
            print(error)
            throw DataError.CouldNotEncode
        }
    }
    
    func loadData() throws {
        let pathURL: URL?
        
        let dataFileUrl = getDataFile(dataFile: dataFileName)
        
        if FileManager.default.fileExists(atPath: dataFileUrl.path) {
            pathURL = dataFileUrl
            print("loading from user data!")
        } else {
            pathURL = Bundle.main.url(forResource: filename, withExtension: "plist")
        }
        
        if let dataURL = pathURL {
            
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
