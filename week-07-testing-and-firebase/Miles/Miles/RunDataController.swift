//
//  RunDataController.swift
//  Miles
//
//  Created by Isaac Sheets on 2/26/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation
import Firebase

struct Run {
    var date: Date
    var miles: Double
    var notes: String
}

class RunDataController {
    //store reference to data base
    var db: Firestore!
    
    //store our local data
    var runData = [Run]()
    
    //closure to notify view controller of data changes
    var onDataUpdate: (([Run]) -> Void)!
    
    
    init() {
        //use the default settings
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        //get reference to our database
        db = Firestore.firestore()
    }
    
    //fetch data intially and add a listener for any new data
    func loadData() {
        db.collection("runs").addSnapshotListener { querySnapshot, error in
            //make sure we got the collection
            guard let collection = querySnapshot else {
                print("Error fetching collection: \(error!)")
                return
            }
            
            //get the docs
            let docs = collection.documents
            
            //empty our data out
            self.runData.removeAll()
            
            //append to our list
            for doc in docs {
                //get the data dictionary from the document
                let data = doc.data()
                //get the data fields and downcast to appropriate types
                let date = (data["Date"] as! Timestamp).dateValue()
                let miles = data["Miles"] as? Double
                let notes = data["Notes"] as! String
                
                //construct object
                let run = Run(date: date, miles: miles ?? 0, notes: notes)
                
                self.runData.append(run)
            }
            
            self.onDataUpdate(self.runData)
        }
    }
    
    
}


