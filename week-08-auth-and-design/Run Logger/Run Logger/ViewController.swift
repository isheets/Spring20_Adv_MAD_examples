//
//  ViewController.swift
//  Run Logger
//
//  Created by Isaac Sheets on 3/4/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var runs = [Run]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        runs = [Run(title: "Morning run", date: Date(), miles: 3.1, duration: 21.45 * 60, notes: "Great 5k"), Run(title: "Lunch run", date: Date(), miles: 5.5, duration: 37.30 * 60, notes: "Long easy miles")]
        
        //remove extra cells
        tableView.tableFooterView = UIView()
        
        //set background color for main view
        view.backgroundColor = .black
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunCell") as? RunTableViewCell
        
        let run = runs[indexPath.row]
        
        cell?.titleLabel.text = run.title
        cell?.titleLabel.sizeToFit()
        cell?.dateLabel.text = run.formatDate()
        cell?.milesLabel.text = String(run.miles)
        cell?.timeLabel.text = run.getTime()
        cell?.paceLabel.text = run.getPace()
        
        return cell!
        
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        if segue.identifier == "SaveSegue" {
            let source = segue.source as! AddRunViewController
            
            if let newRun = source.newRun {
                runs.append(newRun)
                runs.sort(by: {(r1, r2) in r1.date.compare(r2.date) == .orderedDescending})
                tableView.reloadData()
            }
        }
    }


}

