//
//  RunTableViewController.swift
//  miles_demo
//
//  Created by Isaac Sheets on 2/27/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class RunTableViewController: UITableViewController {
    //get data controller instance
    var dc = RunDataController()
    //all the run objects
    var runData = [Run]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pass the data to newData method when done
        dc.onDataUpdate = {[weak self] (data: [Run]) -> Void in self?.newData(data: data)}
        
        //load init data and attach listener for changes
        dc.loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func newData(data: [Run]) {
        //assign data to property
        runData = data
        //sort data array by date
        runData.sort(by: {(r1, r2) in r1.date.compare(r2.date) == .orderedDescending})
        //update table view
        tableView.reloadData()
    }
    
    //unwind from AddRunVC
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "SaveSegue" {
            let source = segue.source as! AddRunController
            //pass data to data controller with default values just in case
            dc.writeData(date: source.date ?? Date(), miles: source.miles ?? 0, notes: source.notes ?? "")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return runData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunCell", for: indexPath)

        //get the run object we're working with
        let run = runData[indexPath.row]
        
        // Configure the cell...
        cell.textLabel?.text = run.getDate()
        cell.detailTextLabel?.text = "\(String(run.miles)) mi"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
