//
//  ViewController.swift
//  countries
//
//  Created by Isaac Sheets on 2/2/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //
    var continentsList = [String]()
    var continentsDataController = ContinentsDataController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            try continentsDataController.loadData()
            continentsList = continentsDataController.getContinents()
        } catch {
            print(error)
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continentsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = continentsList[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountrySegue" {
            //get reference to DetailViewController (need to downcast from UIViewController)
            let detailVC = segue.destination as! DetailViewController
            //get the cell that triggered the segue (need to downcast)
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            //set data in destination controller
            if let selection = indexPath?.row {
                detailVC.selectedContinent = selection
                detailVC.title = continentsList[selection]
                detailVC.continentsData = continentsDataController
            }
        }
    }
}

