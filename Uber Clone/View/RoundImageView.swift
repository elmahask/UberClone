//
//  RoundImageView.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/23/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        setupView()
    }

    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
}
