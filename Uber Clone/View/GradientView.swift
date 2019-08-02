//
//  GradientView.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/23/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit

class GradientView: UIView {

    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        gradient.frame = self.layer.bounds
        gradient.colors = [UIColor.white.cgColor,UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint.init(x: 0, y: 1)
        gradient.locations = [0.8,1.0]
        self.layer.addSublayer(gradient)
    }

}
