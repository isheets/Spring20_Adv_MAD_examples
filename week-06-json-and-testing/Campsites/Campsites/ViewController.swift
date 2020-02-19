//
//  ViewController.swift
//  Campsites
//
//  Created by Isaac Sheets on 2/18/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //list of states for picker
    let stateOptions = ["CO", "CA", "FL", "NM", "UT"]
    //holds the currently selected state
    var selectedState = String()
    //instance of data controller
    var campsiteDC = CampsiteDataController()
    //local copy of data
    var data = [Campsite]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the intial state
        selectedState = stateOptions[0]
        
        //set the function to notify when response is complete
        campsiteDC.onDataUpdate = {[weak self] (data:[Campsite]) in self?.searchDone(campsites: data)}
    }
    
    //executes the search
    @IBAction func searchCampsites(_ sender: Any) {
        do {
            try campsiteDC.loadJson(stateCode: selectedState)
            //block user events and show spinner while fetching the campsites
            let alert = UIAlertController(title: nil, message: "Searching in \(selectedState)...", preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating();

            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    //called when the json data has been parsed
    //trigger segue and set local data
    func searchDone(campsites: [Campsite]) {
        //dismiss the loading alery
        dismiss(animated: true, completion: nil)
        
        //set data property
        data = campsites
        //execute the segue
        performSegue(withIdentifier: "SearchResults", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check id of segue
        if segue.identifier == "SearchResults" {
            //downcast destination vc
            let resultsVC = segue.destination as! ResultsViewController
            //set the title
            resultsVC.title = "\(selectedState) Campsites"
            //pass the data
            resultsVC.results = data
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedState = stateOptions[row]
    }
    
    
}

