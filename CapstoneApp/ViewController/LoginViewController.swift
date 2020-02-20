//
//  LoginViewController.swift
//  CapstoneApp
//
//  Created by Consultant on 2/17/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTouch(_ sender: UIButton) {
        print("loginbutton")
        //TODO: Check with Firebase to see if the data is available
    }
    
    @IBAction func signupButtonTouch(_ sender: UIButton) {
        print("signupbutton")
        //TODO: Open Alert With Text fields for signup!
        // Send that data to firebase
    }
    
    
}
