//
//  FourthViewController.swift
//  music
//
//  Created by Isaac Sheets on 1/6/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    //constants for the url schemes that we'll need to check/use
    let spotifyScheme = "spotify://"
    let appleMusicScheme = "music://"
    let itunesScheme = "http://www.apple.com/music"

    //open an app that we have access to
    func openApp(scheme: String) {
      if let url = URL(string: scheme) {
        UIApplication.shared.open(url, options: [:], completionHandler: {
          (success) in
          print("Open \(scheme): \(success)")
        })
      }
    }

    //func for checking if we have access to a given url scheme
    func schemeAvailable(scheme: String) -> Bool {
        if let url = URL(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }

    //open spotify if installed, apple music if installed, or navigate to iTunes on safari as last resort
    @IBAction func gotToMusic(_ sender: Any) {
        
        //check for access
        let spotifyInstalled = schemeAvailable(scheme: spotifyScheme)
        let appleMusicInstalled = schemeAvailable(scheme: appleMusicScheme)
        
        if spotifyInstalled {
            //we have spotify access :)
            openApp(scheme: spotifyScheme)
        } else if appleMusicInstalled {
            //we don't have spotify :( give apple music a try
            openApp(scheme: appleMusicScheme)
        } else {
            //don't even have apple music :(( just open itunes in safari
            openApp(scheme: itunesScheme)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
