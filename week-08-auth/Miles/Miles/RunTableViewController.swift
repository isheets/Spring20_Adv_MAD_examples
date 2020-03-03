//
//  RunTableViewController.swift
//  Miles
//
//  Created by Isaac Sheets on 2/26/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class RunTableViewController: UITableViewController {
    
    //instantiate data controller
    var runDC = RunDataController()
    
    //local data
    var runData = [Run]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set completion handler
        runDC.onDataUpdate = {[weak self] (data: [Run]) -> Void in self?.newData(data: data)}
        
        //load the data
        runDC.loadData()

    }
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "SaveSegue" {
            let sourceVC = segue.source as! AddRunController
            //double check that we have values
            if let userMiles = sourceVC.miles, let userDate = sourceVC.date {
                //check the notes
                if let userNotes = sourceVC.notes {
                    //write the data
                    runDC.writeData(date: userDate, miles: userMiles, notes: userNotes)
                } else {
                    //write data with empty notes
                    runDC.writeData(date: userDate, miles: userMiles, notes: "")
                }
            }
        }
        
    }
    
    func newData(data: [Run]) {
        //set the data
        runData = data
        //sort the data by date in descending order
        runData.sort(by: {(r1, r2) in r1.date.compare(r2.date) == .orderedDescending })
        //reload the tableview
        tableView.reloadData()
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunCell", for: indexPath)
        
        //get the run object
        let run = runData[indexPath.row]
        
        //set the labels
        cell.textLabel?.text = run.getDate()
        cell.detailTextLabel?.text = "\(String(run.miles)) mi"

        return cell
    }
    
    //pass data before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            //downcast destination
            let vc = segue.destination as! DetailViewController
            //get index of run to view
            let idx = tableView.indexPath(for: (sender as! UITableViewCell))
            //pass the run along
            vc.run = runData[idx!.row]
            
        }
    }

}
