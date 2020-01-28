//
//  ArtistAlbumsController.swift
//  music_demo
//
//  Created by Isaac Sheets on 1/23/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

enum DataError: Error {
    case BadFilePath
    case CouldNotDecodeData
    case NoData
}

class ArtistAlbumsController {
    //properties
    var artistAlbumsData: [ArtistAlbums]?
    let filename = "artist-albums"
    
    //read from plist and decode to array of ArtistAlbums struct
    func loadData() throws {
        print("Loading Data....")
        
        if let pathUrl = Bundle.main.url(forResource: filename, withExtension: "plist") {
            //found the file!
            let decoder = PropertyListDecoder()
            
            do {
                let data = try Data(contentsOf: pathUrl)
                artistAlbumsData = try decoder.decode([ArtistAlbums].self, from: data)
                print("Data loaded")
            } catch {
                throw DataError.CouldNotDecodeData
            }
            
        } else {
            throw DataError.BadFilePath
        }
    }
    
    //get all the artists and return array of strings
    func getAllArtists() throws -> [String] {
        var artists = [String]()
        
        //make sure we have data
        if let data = artistAlbumsData {
            //we have data
            for artistStruct in data {
                artists.append(artistStruct.name)
            }
            return artists
        } else {
            throw DataError.NoData
        }
    }
    
    //get all the albums for any of the artists
    func getAlbums(idx: Int) throws -> [String] {
        //make sure we have data
        if let data = artistAlbumsData {
            //good data
            return data[idx].albums
        } else {
            //no data
            throw DataError.NoData
        }
    }
}
