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
    
    //action connection for date picker
    @IBAction func datePickerChanged(_ sender: Any) {
    
    }
    
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
