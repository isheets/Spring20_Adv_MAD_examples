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
        //get app instance
        let app = UIApplication.shared
        
        //subscribe to willResignActive notification
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.applicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: app)
        
        //subscribe to
        
        do {
            try continentsDataController.loadData()
            continentsList = continentsDataController.getContinents()
        } catch {
            print(error)
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //called automatically when UIApplicationWillResignActive notification is posted for our app
    //needs to take an NSNotification as parameter
    @objc func applicationWillResignActive(_ notification: NSNotification) {
        do {
            try continentsDataController.writeData()
        } catch {
            print(error)
        }
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
        } else if segue.identifier == "ContinentSegue" {
            //get access to destination controller (need to downcast)
            let infoVC = segue.destination as! ContinentInfoTableViewController
            //get the selected cell
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            //set the continent name in destination
            infoVC.continent = continentsList[indexPath!.row]
            //get the country list
            let countryList = continentsDataController.getCountries(idx: indexPath!.row)
            //set number of countries (cast integer to string)
            infoVC.number = String(countryList.count)
            infoVC.title = continentsList[indexPath!.row]
        }
    }
}

