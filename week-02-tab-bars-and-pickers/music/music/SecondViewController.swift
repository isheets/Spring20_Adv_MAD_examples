//
//  SecondViewController.swift
//  music
//
//  Created by Isaac Sheets on 1/4/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //arrays to supply hard coded data to the picker -- not recommended for production. use plists
    let genres = ["Rock", "Country", "Indie", "Hip Hop", "Pop", "House"]
    let decades = ["1960s", "1970s", "1980s", "1990s", "2000s", "2010s"]

    
    @IBOutlet weak var musicDecadePicker: UIPickerView!
    @IBOutlet weak var choiceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //need two columns for this, so return 2
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //return the correct number of items depending on the component we're working with
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return genres.count
        } else if component == 1 {
            return decades.count
        }
        else {
            print("Unknown component: \(component) in numberOfRowsInComponent method...")
            return -1
        }
    }
    
    //create the title for each row (once again dependent on the component we're working with)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //genre component
        if component == 0 {
            return genres[row]
        }
        //decade component
        else if component == 1{
            return decades[row]
        }
        //something went horribly wrong...
        else {
            print("Unknown component: \(component) in titleForRow forComponent method...")
            return "no title"
        }
        
    }
    
    //change the label when the selection in either component is changed
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let genre = pickerView.selectedRow(inComponent: 0) //get selected row from genre component
        let decade = pickerView.selectedRow(inComponent: 1) //get selected row from decade component
        
        choiceLabel.text = "You like \(genres[genre]) from the \(decades[decade])."
    }


}

