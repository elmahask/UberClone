//
//  UIViewControllerExts.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/25/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit

extension UIViewController {
    func dismissKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
