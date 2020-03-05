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
        //use default settings for firestore
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        //init db ref
        db = Firestore.firestore()
    }
    
    //load the data
    func loadData() {
        //get authenticated user's id
        let authUserID = Auth.auth().currentUser?.uid
        
        if let userID = authUserID {
            db.collection("users").document(userID).collection("runs").addSnapshotListener({querySnapshot, error in
                //check for results
                guard let collection = querySnapshot else {
                    print("error fetching colllection: \(error!)")
                    return
                }
                //get all the documents in the collection
                let docs = collection.documents
                
                //empty current data
                self.runData.removeAll()
                
                for doc in docs {
                    let data = doc.data()
                    //get the date
                    let date = (data["Date"] as! Timestamp).dateValue()
                    //get the miels
                    let miles = data["Miles"] as! Double
                    //get notes
                    let notes = data["Notes"] as! String
                    
                    //get the id
                    let id = doc.documentID
                    
                    //construct object
                    let newRun = Run(date: date, miles: miles, notes: notes, id: id)
                    
                    self.runData.append(newRun)
                }
                
                //pass data on to new view controller
                self.onDataUpdate(self.runData)
            })
        } else {
            print("could not find authenticated user's id")
        }
        

    }
    
    //write a new run to database
    func writeData(date: Date, miles: Double, notes: String) {
        //get authenticated user's id
        let authUserID = Auth.auth().currentUser?.uid
        
        if let userID = authUserID {
        
            db.collection("users").document(userID).collection("runs").addDocument(data: [
                "Date": Timestamp(date: date),
                "Miles": miles,
                "Notes": notes
            ])
        }
    }
    
}
