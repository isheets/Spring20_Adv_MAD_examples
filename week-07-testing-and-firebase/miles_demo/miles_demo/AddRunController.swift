//
//  AddRunController.swift
//  miles_demo
//
//  Created by Isaac Sheets on 2/27/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class AddRunController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    //outlet connections
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var milesTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(AddRunController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //override when user enters newline character
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        //all other characters are fine
        return true
    }
    
    @objc func didTapView() {
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
