//
//  AddRunController.swift
//  Miles
//
//  Created by Isaac Sheets on 2/26/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class AddRunController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    //outlet connections
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var milesTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    //user input variables
    var notes: String?
    var date: Date?
    var miles: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(AddRunController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    @objc func didTapView(){
      self.view.endEditing(true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check to make sure we're only saving when the user presses save button
        if segue.identifier == "SaveSegue" {
            //check to make sure they at least entered mileage
            if let userMiles = Double(milesTextField.text!) {
                miles = userMiles
                date = datePicker.date
                if notesTextView.text.isEmpty == false {
                    notes = notesTextView.text
                }
            } else {
                print("Not a valid mileage: \(milesTextField.text!)")
            }
        }
    }

}
