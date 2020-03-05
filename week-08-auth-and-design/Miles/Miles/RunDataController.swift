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
    var id: String
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
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
            
        //get the user id of the currently authenticated user
        let authUserID = Auth.auth().currentUser?.uid
        if let userID = authUserID {
            //navigate to the user's run collection and add listener
            db.collection("users").document(userID).collection("runs").addSnapshotListener { querySnapshot, error in
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
                    
                    //get the id
                    let id = doc.documentID
                    //construct object
                    let run = Run(date: date, miles: miles ?? 0, notes: notes, id: id)
                    
                    
                    self.runData.append(run)
                }
                //pass data to view controller
                self.onDataUpdate(self.runData)
            }
        } else {
            print("could not read data, no auth user")
        }
    }

    func writeData(date: Date, miles: Double, notes: String) {
        
        //try to get the authenticated user's ID
        let authUserID = Auth.auth().currentUser?.uid
        if let userID = authUserID {
            // Add another run document with a generated ID to the authenticated user's collection of runs
            db.collection("users").document(userID).collection("runs").addDocument(data: [
                "Date": Timestamp(date: date),
                "Miles": miles,
                "Notes": notes,
            ], completion: { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("new document added successfully!")
                }
            })
        
        } else {
            print("could not write, no auth user")
        }
    }
}


