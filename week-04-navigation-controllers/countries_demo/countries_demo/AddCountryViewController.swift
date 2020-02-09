//
//  AddCountryViewController.swift
//  countries_demo
//
//  Created by Isaac Sheets on 2/6/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class AddCountryViewController: UIViewController {
    
    //var to store user input
    var addedCountry = String()
    
    //connect to textfield
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //only care if we're saving
        if segue.identifier == "save" {
            if textfield.text?.isEmpty == false {
                addedCountry = textfield.text!
            }
        }
    }

}
