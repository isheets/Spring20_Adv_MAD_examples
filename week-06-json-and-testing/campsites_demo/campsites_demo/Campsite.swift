//
//  Campsite.swift
//  campsites_demo
//
//  Created by Isaac Sheets on 2/20/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation

struct Campsite: Decodable {
    let name: String
    let description: String
    let directionsoverview: String
}

struct CampsiteData: Decodable {
    var data = [Campsite]()
}
