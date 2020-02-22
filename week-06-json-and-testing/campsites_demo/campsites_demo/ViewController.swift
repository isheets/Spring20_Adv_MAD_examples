//
//  ViewController.swift
//  campsites_demo
//
//  Created by Isaac Sheets on 2/20/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //list of states
    let stateOptions = ["CO", "CA", "FL", "NM", "UT"]
    //holds current selected state
    var selectedState = String()
    //instantiate data controller
    var campsiteDC = CampsiteDataController()
    //local copy of results
    var data = [Campsite]()

    @IBAction func searchCampsites(_ sender: Any) {
        //load data
        campsiteDC.loadJson(stateCode: selectedState)
        
        let alert = UIAlertController(title: nil, message: "Searching in \(selectedState)", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        //add spinner
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //init to first item in state array
        selectedState = stateOptions[0]
        
        campsiteDC.onDataUpdate = {[weak self](data: [Campsite]) in self?.searchDone(campsite: data)}
    }
    
    //notified when we have data
    func searchDone(campsite: [Campsite]) {
        dismiss(animated: true, completion: nil)
        
        data = campsite
        
        performSegue(withIdentifier: "SearchResults", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check segue id
        if segue.identifier == "SearchResults" {
            //downcast destination
            let resultsVC = segue.destination as! ResultsViewController
            
            resultsVC.title = "\(selectedState) Campsites"
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

