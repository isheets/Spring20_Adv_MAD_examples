//
//  ArtistAlbums.swift
//  music_demo
//
//  Created by Isaac Sheets on 1/23/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

struct ArtistAlbums: Decodable {
    let name: String
    let albums: [String]
}
