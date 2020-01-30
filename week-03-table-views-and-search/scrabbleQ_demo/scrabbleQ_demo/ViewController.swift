//
//  ViewController.swift
//  scrabbleQ_demo
//
//  Created by Isaac Sheets on 1/30/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //variables
    var words = [String]()
    
    //connect to data controller
    var data = DataController()
    
    //make a search controller
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load data from DataController
        do {
            try data.loadWords()
            words = try data.getWords()
            
            let resultsController = SearchResultsController()
            resultsController.allWords = words
            
            searchController = UISearchController(searchResultsController: resultsController)
            searchController.searchBar.placeholder = "Filter"
            searchController.searchBar.sizeToFit()
            
            tableView.tableHeaderView = searchController.searchBar
            searchController.searchResultsUpdater = resultsController
            
        } catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get cell from from queue
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrabbleCell", for: indexPath)
        //set label
        cell.textLabel?.text = words[indexPath.row]
        
        return cell
    }
    
    //delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Word Selected", message: "You selected \(words[indexPath.row])", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

