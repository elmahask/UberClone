//
//  RoundedShadowView.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/23/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize.init(width: 0, height: 5)
    }

}
