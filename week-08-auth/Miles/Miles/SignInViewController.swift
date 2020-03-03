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
    
    //default auth UI instance
    let authUI = FUIAuth.defaultAuthUI()

    @IBAction func logIn(_ sender: Any) {
        
        print("trying to present view controller")
        //get the auth navigation controller
        let authViewController = authUI?.authViewController()
        
        present(authViewController!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //configure and present the auth UI view controller as the initial entry point for our app
        authUI?.delegate = self
        
        //config the auth providers
        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth()
        ]
        //set the auth providers
        authUI?.providers = providers
        
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
           if let authUser = user {
               print(authUser.uid)
            
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "rootNav")
                vc.modalPresentationStyle = .fullScreen
                //present the root view controller
                present(vc, animated: true, completion: nil)
           } else {
               print(error!.localizedDescription)
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
