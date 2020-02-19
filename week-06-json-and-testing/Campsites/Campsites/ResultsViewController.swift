//
//  ResultsViewController.swift
//  Campsites
//
//  Created by Isaac Sheets on 2/19/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {

    var results = [Campsite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return results.count
}


override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CampsiteCell", for: indexPath)
    
    //set the title of cell label
    cell.textLabel!.text = results[indexPath.row].name
    
    return cell
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            //get the selected campsite
            let idx = tableView.indexPath(for: sender as! UITableViewCell)!.row
            let selectedCampsite = results[idx]
            //get reference to detail vc
            let detailVC = segue.destination as! DetailViewController
            
            //set detail vc properties
            detailVC.title = selectedCampsite.name
            detailVC.siteDirections = selectedCampsite.directionsoverview
            detailVC.siteDescription = selectedCampsite.description
        }
    }

}
