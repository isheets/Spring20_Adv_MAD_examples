//
//  DetailViewController.swift
//  Miles
//
//  Created by Isaac Sheets on 2/26/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //outlet connections
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    //run object
    var run: Run?
    
    override func viewWillAppear(_ animated: Bool) {
        //check to make sure we have the run
        if let myRun = run {
            dateLabel.text = myRun.getDate()
            milesLabel.text = String(myRun.miles)
            notesLabel.text = String(myRun.notes)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
