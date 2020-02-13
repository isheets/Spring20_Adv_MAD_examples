//
//  ViewController.swift
//  countries_demo
//
//  Created by Isaac Sheets on 2/6/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var continentsDataController = ContinentsDataController()
    var continentsList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Load data and populate list
        do {
            try continentsDataController.loadData()
            continentsList = continentsDataController.getContinents()
        } catch {
            print(error)
        }
        
        //make title large
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continentsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContinentCell", for: indexPath)
        
        //set text label based on index of cell
        cell.textLabel?.text = continentsList[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountrySegue" {
            
            let detailVC = segue.destination as! DetailViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            
            if let selection = indexPath?.row {
                detailVC.selectedContinent = selection
                detailVC.title = continentsList[selection]
                detailVC.continentsDataController = continentsDataController
            }
        } else if segue.identifier == "ContinentSegue" {
            let infoVC = segue.destination as! ContinentInfoTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            
            //set properties in destination
            infoVC.continent = continentsList[indexPath!.row]
            
            let countryList = continentsDataController.getCountries(idx: indexPath!.row)
            infoVC.number = String(countryList.count)
            infoVC.title = continentsList[indexPath!.row]
        }
    }


}

