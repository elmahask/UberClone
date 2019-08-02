//
//  AuthorizedVC.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/25/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit
import Firebase

class AuthorizedVC: UIViewController {

    @IBOutlet weak var authorizedBtnPressed: RoundedShadowButton!
    @IBOutlet weak var emailField: RoundedCornerTextField!
    @IBOutlet weak var passwordField: RoundedCornerTextField!
    @IBOutlet weak var segmentedBtnControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindKeyboard()
        view.dismissKeyboard()
    }

    @IBAction func dismissAuthorizedBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func authorizedBtnPressed(_ sender: Any) {
        authorizedBtnPressed.animateButton(shouldLoad: true, withMessage: "")
        guard let email = self.emailField.text, let password = self.passwordField.text else {
            print("email/password can't be empty")
            return
        }
        print(email,password)
        var isDriver = true
        
        if self.segmentedBtnControl.selectedSegmentIndex == 0 {
            isDriver = false
        }
        
        AuthManager.signInOrCreateUser(email: email, password: password, isDriver: isDriver) { (isSuccess) in
            print("isSuccess \(isSuccess)")
            self.authorizedBtnPressed.animateButton(shouldLoad: false, withMessage: "")
            self.dismiss(animated: true, completion: nil)
        }
        
        print("is Driver .... \(isDriver)")
    }
}
