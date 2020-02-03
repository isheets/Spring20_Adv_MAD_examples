//
//  AddCountryViewController.swift
//  countries
//
//  Created by Isaac Sheets on 2/3/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class AddCountryViewController: UIViewController {
    
    //connect textfield
    @IBOutlet weak var countryTextField: UITextField!
    
    //var to store user input
    var addedCountry = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //only care if they hit save
        if segue.identifier == "save" {
            //make sure they entered info
            if countryTextField.text?.isEmpty == false {
                addedCountry = countryTextField.text!
            }
        }
    }
    

}
