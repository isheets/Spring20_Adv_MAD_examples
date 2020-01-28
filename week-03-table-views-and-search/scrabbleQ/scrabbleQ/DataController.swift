//
//  DataController.swift
//  scrabbleQ
//
//  Created by Isaac Sheets on 1/27/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

enum DataError: Error {
    case NoDataFile
    case CouldNotDecode
    case NoWords
}

class DataController {
    var qNoUWords: [String]?
    let filename = "qwordswithoutu1"
    
func loadWords() throws {
    //check if we have the file
    if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist") {
        //plist decoder object
        let plistDecoder = PropertyListDecoder()
        
        do {
            //try to get the data and decode into array of strings
            let data = try Data(contentsOf: pathURL)
            qNoUWords = try plistDecoder.decode([String].self, from: data)
        } catch {
            print(error)
            throw DataError.CouldNotDecode
        }
    } else {
        //could not find file
        throw DataError.NoDataFile
    }
}
    
    //send all the words back in array of strings
    func getWords() throws -> [String] {
        //check to make sure we have the words via conditional unwrapping
        if let words = qNoUWords {
            //got words!
            return words
        } else {
            //don't have any words :( throw error
            throw DataError.NoWords
        }
    }
}
