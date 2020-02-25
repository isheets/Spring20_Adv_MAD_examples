//
//  DetailViewController.swift
//  Campsites
//
//  Created by Isaac Sheets on 2/19/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //data
    var siteDescription = String()
    var siteDirections = String()

    //connections
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var directionsLabel: UILabel!
    
    //set the label text
    override func viewWillAppear(_ animated: Bool) {
        descriptionLabel.text = siteDescription
        directionsLabel.text = siteDirections
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
