//
//  ContinentInfoTableViewController.swift
//  countries
//
//  Created by Isaac Sheets on 2/3/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ContinentInfoTableViewController: UITableViewController {
    
    //properties to hold info
    var continent = String()
    var number = String()
    
    //detail label outlets
    @IBOutlet weak var continentName: UILabel!
    @IBOutlet weak var countryNumber: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        continentName.text = continent
        countryNumber.text = number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
