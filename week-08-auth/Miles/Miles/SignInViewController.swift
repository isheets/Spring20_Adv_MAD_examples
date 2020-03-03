//
//  SignInViewController.swift
//  Miles
//
//  Created by Isaac Sheets on 3/2/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit
import FirebaseUI

class SignInViewController: UIViewController, FUIAuthDelegate {
    
    //create default auth UI instance
    let authUI = FUIAuth.defaultAuthUI()

    @IBAction func logIn(_ sender: Any) {
        
        print("trying to present view controller")
        //get the auth navigation controller
        let authViewController = authUI?.authViewController()
        //hand over control to FirebaseUI
        present(authViewController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //configure and present the auth UI view controller as the initial entry point for our app
        authUI?.delegate = self
        
        //config the auth providers array
        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth()
        ]
        //set the auth providers
        authUI?.providers = providers
        
    }
    
    //FUIAuthDelegat method which is called when authentication is completed successfully or errors out
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        //make sure we got the user object
        if user != nil {
            //get access to storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //get instance of the root nav controller
            let vc = storyboard.instantiateViewController(withIdentifier: "rootNav")
            //set it to full screen instead of popover
            vc.modalPresentationStyle = .fullScreen
            //present the root view controller
            present(vc, animated: true, completion: nil)
        } else {
            print(error!.localizedDescription)
        }
    }
}
