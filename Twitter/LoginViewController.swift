//
//  LoginViewController.swift
//  Twitter
//
//  Created by Henry Rivera on 10/7/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userLoggedIn"){
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    @IBAction func onLoginClick(_ sender: Any) {
        let baseURL = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: baseURL, success: {
            // anytime user logs in a userLoggedIn var will be created and set to true. Next time I login boolean will determine whether or not I have to log in again
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }, failure: { (Error) in
            print("Could not login!")
        })
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
