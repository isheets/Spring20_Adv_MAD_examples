//
//  SearchResultsController.swift
//  scrabbleQ_demo
//
//  Created by Isaac Sheets on 1/30/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {

    var allWords = [String]()
    var filteredWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScrabbleCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrabbleCell", for: indexPath)
    
        cell.textLabel?.text = filteredWords[indexPath.row]
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //get user entry
        let searchString = searchController.searchBar.text
        
        filteredWords.removeAll()
        
        if searchString?.isEmpty == false {
            
            //closure to filter allWords
            let searchFilter: (String) -> Bool = {(word) in
                let range = word.range(of: searchString!, options: .caseInsensitive)
                
                return range != nil
            }
            
            filteredWords = allWords.filter(searchFilter)
        }
        
        //update table
        tableView.reloadData()
    }

}
