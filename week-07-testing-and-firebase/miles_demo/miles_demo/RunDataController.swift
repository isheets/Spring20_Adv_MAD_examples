//
//  RunDataController.swift
//  miles_demo
//
//  Created by Isaac Sheets on 2/27/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation
import Firebase

struct Run {
    var date: Date
    var miles: Double
    var notes: String
    var id: String
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

class RunDataController {
    //store reference to database
    var db: Firestore!
    //store data locally
    var runData = [Run]()
    //notify view controller
    var onDataUpdate: (([Run]) -> Void)!
    
    init() {
        //use default settings
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        //init db ref
        db = Firestore.firestore()
    }
    
}
