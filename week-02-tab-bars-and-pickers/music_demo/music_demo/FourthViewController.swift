//
//  FourthViewController.swift
//  music_demo
//
//  Created by Isaac Sheets on 1/28/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    let spotifyScheme = "spotify://"
    let appleScheme = "music://"
    let itunesScheme = "http://www.apple.com/music"
    
    func schemeAvailable(scheme: String) -> Bool {
        //make url from scheme
        if let url = URL(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func openApp(scheme: String) {
        if let url = URL(string: scheme) {
            UIApplication.shared.open(url, options: [:], completionHandler: {
                (success) in
                print("successfully opened \(scheme)")
                //save data
                //persist user location in app
            })
        }
    }
    
    
    @IBAction func goToMusic(_ sender: Any) {
        
        let spotifyInstalled = schemeAvailable(scheme: spotifyScheme)
        let appleMusicInstalled = schemeAvailable(scheme: appleScheme)
        
        if spotifyInstalled {
            openApp(scheme: spotifyScheme)
        } else if appleMusicInstalled{
            openApp(scheme: appleScheme)
        } else {
            openApp(scheme: itunesScheme)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
