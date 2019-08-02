//
//  UIViewExts.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/25/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alphaValue:CGFloat, duration:TimeInterval){
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
    
    func bindKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardNotification(_ notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
            let beginFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let deltaFrameY = endFrame.origin.y - beginFrame.origin.y
            UIView.animateKeyframes(withDuration: 0.0, delay: duration, options: UIView.KeyframeAnimationOptions(rawValue: animationCurve), animations: {
                self.frame.origin.y += deltaFrameY
            },completion: nil)
        }
        
    }
    
    
    
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.endEditing(true)
    }
}
