//
//  RoundedCornerTextField.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/25/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit

class RoundedCornerTextField: UITextField {

    var textRectOffset : CGFloat = 10
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(x: 0 + textRectOffset, y: 0 + (textRectOffset / 2), width: self.frame.width - textRectOffset, height: self.frame.height + textRectOffset)
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(x: 0 + textRectOffset, y: 0 + (textRectOffset / 2), width: self.frame.width - textRectOffset, height: self.frame.height + textRectOffset)
//    }
}
