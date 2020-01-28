//
//  SearchResultsController.swift
//  scrabbleQ
//
//  Created by Isaac Sheets on 1/27/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    
    //arrays for all the words and the ones matching the filter
    var allWords = [String]()
    var filteredWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //no storyboard scene so programatically register the cell reuse identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScrabbleCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredWords.count
    }
    
    //delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrabbleCell", for: indexPath)
        cell.textLabel?.text = filteredWords[indexPath.row]
        return cell
    }

    
    //implement the search
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text //get the text entered into search bar
        filteredWords.removeAll() //empty array of filtered words
        
        //make sure we got a value
        if searchString?.isEmpty == false {
            
            //closure to filter through all words
            let searchFilter: (String) -> Bool = {word in
                let range = word.range(of: searchString!, options: .caseInsensitive)
                //range will be nil if the character sequence is no present in the given word
                return range != nil
            }
            
            //use the closure to filter through all words
            filteredWords = allWords.filter(searchFilter)
        }
        //update the table with relevant words
        tableView.reloadData()
    }



}
