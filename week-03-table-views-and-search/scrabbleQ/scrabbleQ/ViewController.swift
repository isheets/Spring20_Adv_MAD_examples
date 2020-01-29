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
var qNoUWords = [String]()
var qWords = [String]()
//constants
let qSection = 0
let qNoUSection = 1
    //connect to data controller
    var data = DataController()
    
    //add instance of seach controller
    var searchController = UISearchController()

override func viewDidLoad() {
    super.viewDidLoad()
    //make sure we load the data first
    do {
        try data.loadWords()
        qNoUWords = try data.getQNoUWords()
        qWords = try data.getQWords()
        //create an instance of our custom results controller
        let resultsController = SearchResultsController()
        //set the all words property in instance based on loaded data
        resultsController.allWords = qNoUWords + qWords
        //tell the search controller to use our
        searchController = UISearchController(searchResultsController: resultsController)
        //add some placeholder text
        searchController.searchBar.placeholder = "Filter"
        searchController.searchBar.sizeToFit() //make it fit the parent view
        //add a header that consists of the search bar that belongs to our search controller
        tableView.tableHeaderView = searchController.searchBar
        //tell it which object will be updating the results
        searchController.searchResultsUpdater = resultsController
    } catch {
        //should probably handle the error more robustly...
        print("could not load data")
    }
}
    
    //DataSource Methods

    //how many sections do we want?
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
//customize the number of rows in each section (group)
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //switch based on section parameter
    if section == qSection {
        return qWords.count
    } else {
        return qNoUWords.count
    }
    
}

//displays the cells
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    //get the section
    let section = indexPath.section
    
    var word: String
    //get word based on section
    if section == qSection {
        word = qWords[indexPath.row]
    } else {
        word = qNoUWords[indexPath.row]
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ScrabbleCell", for: indexPath)
    //we know there's a text label based on table style so we can safely set
    cell.textLabel?.text = word
    return cell
}
    
    //Delegate Method
    //alert the selected word when selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        
        var word: String
        //get word based on section
        if section == qSection {
            word = qWords[indexPath.row]
        } else {
            word = qNoUWords[indexPath.row]
        }
        
        let alert = UIAlertController(title: "Word selected", message: "You selected \(word)", preferredStyle: .alert)
        //create the action button
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction) //add the button
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //make sure the row gets deselected
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerview = view as! UITableViewHeaderFooterView
        headerview.textLabel?.font = UIFont(name: "Helvetica", size: 20)
        headerview.textLabel?.textAlignment = .center
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //tableView.headerView(forSection: section)?.textLabel?.textAlignment = NSTextAlignment.center
        if section == qSection {
            return "Words with Q"
        } else {
            return "Words with Q w/o U"
        }
    }
}

