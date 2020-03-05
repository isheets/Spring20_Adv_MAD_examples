//
//  AddRunViewController.swift
//  Run Logger
//
//  Created by Isaac Sheets on 3/4/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class AddRunViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var milesTextField: UITextField!
    @IBOutlet weak var durationTextField: UILabel!
    @IBOutlet weak var descriptionTextEdit: UITextView!
    
    var newRun : Run?
    var duration : TimeInterval?
    var date = Date()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //placeholder for text edit
        descriptionTextEdit.text = "How did it feel? Rested? Fast? Slow?"
        descriptionTextEdit.textColor = UIColor.lightGray
        descriptionTextEdit.layer.cornerRadius = 5
        
        //tap to dismiss keyboard
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(AddRunViewController.didTapView))
        
        //IMPORTANT this is needed to allow selections on the the tableview cell
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        
        //remove extra cells
        tableView.tableFooterView = UIView()
        
        //set background color for main view
        view.backgroundColor = .black
        
        //set initial date to now
        updateDate(newDate: date)
    }
    
    //set the date property and update date/time label after the user changes datepicker in alertview
    func updateDate(newDate: Date) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy  h:mm a"
        
        let dateString = dateFormatter.string(from: newDate)
        
        dateLabel.text = dateString
        dateLabel.sizeToFit()
        
        date = newDate
    }
    
    //set the duration property and text view after the user selects a duration from the countdown timer in the alertview
    func updateDuration(newDuration: TimeInterval) {
        print(newDuration)
        
        let minutes = (newDuration / 60).truncatingRemainder(dividingBy: 60)
        let hours = (newDuration / 3600)
        
        let hoursRounded = (hours*100).rounded()/100
        
        
        durationTextField.text = "\(String(format: "%.0f", hoursRounded))h \(String(format: "%.0f",  minutes))m"
        duration = newDuration
    }
    
    
    //show pickers in alerts -- this is not greate code and it would be much better to design a popover view and present that instead of just an alert view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        //selected date cell - show date picker in alert
        if indexPath.section == 0 && indexPath.row == 1 {
            let myDatePicker: UIDatePicker = UIDatePicker()
            myDatePicker.timeZone = NSTimeZone.local
            myDatePicker.datePickerMode = .dateAndTime
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
            alertController.view.addSubview(myDatePicker)
            let selectAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.updateDate(newDate: myDatePicker.date)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion:{() in tableView.deselectRow(at: indexPath, animated: true)})
        }
        //selected duration cell - show countdown time picker
        else if indexPath.section == 1 && indexPath.row == 1 {
            let myDatePicker: UIDatePicker = UIDatePicker()
            myDatePicker.timeZone = NSTimeZone.local
            myDatePicker.datePickerMode = .countDownTimer
            
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
            alertController.view.addSubview(myDatePicker)
            let selectAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.updateDuration(newDuration: myDatePicker.countDownDuration)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion:{() in tableView.deselectRow(at: indexPath, animated: true)})
            
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }
    
    //MARK: Keyboard dismissal when pressing done on keyboard in textfield or textview
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       if(text == "\n") {
           textView.resignFirstResponder()
           return false
       }
       return true
    }
    
    //dismiss keyboard on tap
    @objc func didTapView(){
     self.view.endEditing(true)
    }
    
    
    //custom placeholder methods for the TextView since there is no built in "placeholder" functionality
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "How did it feel? Rested? Fast? Slow?"
            textView.textColor = UIColor.lightGray
        }
    }
    
    //configure the backgroud for headers
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //create main view
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 200))
        //set color
        view.backgroundColor = .black
        
        //add a "border" view to the top
        let border = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 1))
        border.backgroundColor = .white
        border.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(border)
        
        //create and configure the label based on what section header we're working with
        let label = UILabel(frame: CGRect(x: 8, y: 8, width: tableView.bounds.width, height: 0))
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .white
        if section == 0 {
            label.text = "Run Info"
        } else {
            label.text = "Run Details"
        }
        //make sure the size is right
        label.sizeToFit()
        view.addSubview(label)
        
        //return constructed header view
        return view
    }


    
    // MARK: - Navigation

    //do some very basic input checking and construct newRun based on user input if they hit save
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SaveSegue" {
            if titleTextField.text?.isEmpty == false && milesTextField.text?.isEmpty == false && duration != nil {
                newRun = Run(title: titleTextField.text!, date: date, miles: Double(milesTextField.text!)!, duration: duration!, notes: descriptionTextEdit.text!)
                
            }
        }
    }
    

}
