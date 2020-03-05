//
//  SignInViewController.swift
//  miles_demo
//
//  Created by Isaac Sheets on 3/3/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import UIKit
import FirebaseUI

class SignInViewController: UIViewController, FUIAuthDelegate {
    
    //create default auth UI instance
    let authUI = FUIAuth.defaultAuthUI()
    
    //action connection for button
    @IBAction func logIn(_ sender: Any) {
        //start sign in
        let authViewController = authUI?.authViewController()
        //hand control off to FirebaseUI
        present(authViewController!, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authUI?.delegate = self
        
        let provider : [FUIAuthProvider] = [
            FUIGoogleAuth()
        ]
        
        authUI?.providers = provider
    }
    
    //delegate method that is called when the user signs in
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if user != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "rootNav")
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        
        }
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
