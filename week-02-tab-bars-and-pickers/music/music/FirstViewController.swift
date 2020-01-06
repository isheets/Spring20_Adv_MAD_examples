//
//  FirstViewController.swift
//  music
//
//  Created by Isaac Sheets on 1/4/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //array to supply hard coded data to the picker -- not recommended for production. use plists
    let genres = ["Rock", "Country", "Indie", "Hip Hop", "Pop", "House"]
    
    @IBOutlet weak var musicPicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //picker view methods for data source
    //how many "columns" or components do we want?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //how many items will be in each "column" or component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    //Picker delegate methods
    //Returns the title for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    
    //called whenever a new row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choiceLabel.text = "You like \(genres[row])"
    }
    


}

