//
//  ArtistAlbumsController.swift
//  music
//
//  Created by Isaac Sheets on 1/5/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

//define our error types
enum DataError: Error {
    case BadFilePath
    case CouldNotDecodeData
    case NoData
}

class ArtistAlbumsController {
    //class properties
    var artistAlbumData: [ArtistAlbums]?
    let filename = "artist-albums"
    
    //load all the data from our plist and throw appropriate errors if we run into issues
    func loadData() throws {
        print("Loading data....")
        //get our file based on the file path
        if let pathURL = Bundle.main.url(forResource: filename, withExtension: "plist") {
            //we
            let decoder = PropertyListDecoder()
            do {
                //get file contents
                let data = try Data(contentsOf: pathURL)
                //decode them using our struct as the type to decode to
                artistAlbumData = try decoder.decode([ArtistAlbums].self, from: data)
                print("Data loaded")
            } catch {
                throw DataError.CouldNotDecodeData
            }
        }
            //error fetching data file
        else {
            throw DataError.BadFilePath
        }
    }
    
    //grab all the artist and return them in array of strings or throw error
    func getAllArtists() throws -> [String] {
        var artists = [String]()
        //make sure we got data
        if let data = artistAlbumData {
            for artist in data {
                artists.append(artist.name)
            }
            
            return artists
        }
        else {
            //we don't have data!
            throw DataError.NoData
        }
        
        
    }

    //get the albums for any of the artists or throw an error
    func getAlbums(idx: Int) throws -> [String] {
        if let data = artistAlbumData {
            return data[idx].albums
        }
        else {
            //we don't have data!
            throw DataError.NoData
        }
    }
}
