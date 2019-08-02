//
//  HomeVC.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/23/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit
import MapKit
import RevealingSplashView

class HomeVC: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var requestRidBtn: RoundedShadowButton!
    var delegate : ViewDelegate!
    var revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width: 80, height: 80), backgroundColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        revealingSplashView.startAnimation()
        revealingSplashView.heartAttack = true
    }


    @IBAction func actionbtnPressed(_ sender: Any) {
        requestRidBtn.animateButton(shouldLoad: true, withMessage: nil)
    }
    @IBAction func menuBtnPressed(_ sender: Any) {
        delegate.toggleLeftSideMenu()
    }
}

