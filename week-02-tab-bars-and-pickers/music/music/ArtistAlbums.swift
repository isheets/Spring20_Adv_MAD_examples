//
//  ArtistAlbums.swift
//  music
//
//  Created by Isaac Sheets on 1/5/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

//model the data based on the structure of our plist file. Must adopt the decodable protocol and the names must match the fields!
struct ArtistAlbums: Decodable {
    let name: String
    let albums: [String]
}
