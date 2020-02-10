//
//  DetailViewController.swift
//  Top Albums 2019
//
//  Created by Isaac Sheets on 2/9/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //connect to image view
    @IBOutlet weak var imageView: UIImageView!
   
    //what image to show
    var imageName : String?
    
    //load the image every time the view appears
    override func viewWillAppear(_ animated: Bool) {
        if let name = imageName {
            imageView.image = UIImage(named: name)
        }
    }

    //implement sharing functionality
    @IBAction func share(_ sender: Any) {
        var imageArray = [UIImage]()
        imageArray.append(imageView.image!)
        
        //create the instance of activity view controller
        let shareScreen = UIActivityViewController(activityItems: imageArray, applicationActivities: nil)
        shareScreen.modalPresentationStyle = .popover
        present(shareScreen, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}
