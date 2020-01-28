//
//  ViewController.swift
//  scrabbleQ
//
//  Created by Isaac Sheets on 1/27/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //hold our words
    var words = [String]()
    //connect to data controller
    var data = DataController()
    
    //add instance of seach controller
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        //make sure we load the data first
        do {
            try data.loadWords()
            words = try data.getWords()
            //configure search results
            let resultsController = SearchResultsController()
            resultsController.allWords = words
            searchController = UISearchController(searchResultsController: resultsController)
            searchController.searchBar.placeholder = "Filter"
            searchController.searchBar.sizeToFit() //make it fit the parent view
            tableView.tableHeaderView = searchController.searchBar //add a header that consists of the search bar
            searchController.searchResultsUpdater = resultsController //tell it where the results are
            
        } catch {
            //should probably handle the error more robustly...
            print("could not load data")
        }
        
    }
    
    //DataSource Methods
    //customize the number of rows in each section (group) -- only one section in this example
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    //displays the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrabbleCell", for: indexPath)
        //we know there's a text label so we can safely set
        cell.textLabel?.text = words[indexPath.row]
        return cell
    }
    
    //Delegate Method
    //alert the selected word when selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Word selected", message: "You selected \(words[indexPath.row])", preferredStyle: .alert)
        //create the action button
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction) //add the button
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //make sure the row gets deselected
    }


}

