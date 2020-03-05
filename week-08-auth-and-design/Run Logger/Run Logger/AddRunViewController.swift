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
        
        //placeholder
        descriptionTextEdit.text = "How did it feel? Rested? Fast? Slow?"
        descriptionTextEdit.textColor = UIColor.lightGray
        descriptionTextEdit.layer.cornerRadius = 5
        
        //tap to dismiss keyboard
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(AddRunViewController.didTapView))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        
        //remove extra cells
        tableView.tableFooterView = UIView()
        
        //set background color for main view
        view.backgroundColor = .black
        
        updateDate(newDate: date)
    }
    
    func updateDate(newDate: Date) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy  h:mm a"
        
        let dateString = dateFormatter.string(from: newDate)
        
        dateLabel.text = dateString
        dateLabel.sizeToFit()
        
        date = newDate
    }
    
    func updateDuration(newDuration: TimeInterval) {
        print(newDuration)
        
        let minutes = (newDuration / 60).truncatingRemainder(dividingBy: 60)
        let hours = (newDuration / 3600)
        
        let hoursRounded = (hours*100).rounded()/100
        
        
        durationTextField.text = "\(String(format: "%.0f", hoursRounded))h \(String(format: "%.0f",  minutes))m"
        duration = newDuration
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        //selected date cell
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
        //selected duration cell
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
    
    //MARK: Keyboard dismissal
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

    @objc func didTapView(){
     self.view.endEditing(true)
    }
    
    
    //placeholder methods
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
    
    //black background for headers
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 200))
            
        view.backgroundColor = .black
        
        let border = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 1))
        border.backgroundColor = .white
        border.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(border)
        
        let label = UILabel(frame: CGRect(x: 8, y: 8, width: tableView.bounds.width, height: 0))
        
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .white
        if section == 0 {
            label.text = "Run Info"
        } else {
            label.text = "Run Details"
        }
        
        label.sizeToFit()
        view.addSubview(label)
        
        return view
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
