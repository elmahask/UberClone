//
//  ContainerVC.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/24/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOteState {
    case collapsed
    case expanded
}

enum ShowWhichVC {
    case homeVC
}

var showVC : ShowWhichVC = .homeVC

class ContainerVC: UIViewController {

    var homeVC : HomeVC!
    var leftSideMenu : LeftSideMenuVC!
    var viewController : UIViewController!
    var isHidden = false
    var sideMenuExpandedOffset : CGFloat = 160
    var tap : UITapGestureRecognizer!
    var currentState : SlideOteState = .collapsed {
        didSet{
            let isShadow = (currentState != .collapsed)
            showShadowForViewController(status:isShadow)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView(screen : showVC)
    }
    
    func initView(screen : ShowWhichVC){
        var presentingController : UIViewController
        
        showVC = screen
        
        if homeVC == nil {
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
        }
        
        presentingController = homeVC
        if let center = viewController {
            center.view.removeFromSuperview()
            center.removeFromParent()
        }
        viewController = presentingController
        view.addSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
    
    override var prefersStatusBarHidden: Bool{
        return isHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
}

extension ContainerVC : ViewDelegate {
    func toggleLeftSideMenu() {
       let notAlreadyExpanded = (currentState != .expanded)
        print("is Expanded \(notAlreadyExpanded)")
        if notAlreadyExpanded {
            addLeftSideMenuVC()
        }
        animateLeftSideMenu(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftSideMenuVC() {
        if leftSideMenu == nil {
            leftSideMenu = UIStoryboard.leftSideMenuVC()
            addChildLeftSideMenu(leftSideMenu)
        }
    }
    
    @objc func animateLeftSideMenu(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            setupCoverWhiteView()
            currentState = .expanded
            animateSideMenuXPosition(targetPosition: viewController.view.frame.width - sideMenuExpandedOffset)
        }else{
            isHidden = !isHidden
            animateStatusBar()
            hideCoverWhiteView()
            animateSideMenuXPosition(targetPosition: 0) { (finished) in
                if finished == true {
                    self.currentState = .collapsed
                    self.leftSideMenu = nil
                }
            }
        }
    }
    
    func addChildLeftSideMenu(_ leftSideMenu:LeftSideMenuVC){
        view.insertSubview(leftSideMenu.view, at: 0)
        leftSideMenu.didMove(toParent: self)
    }
    
    func animateSideMenuXPosition(targetPosition:CGFloat,completion:((Bool)->Void)! = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.viewController.view.frame.origin.x = targetPosition
        }, completion: completion)
        
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    func setupCoverWhiteView(){
        let whiteCover = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCover.alpha = 0.0
        whiteCover.backgroundColor = UIColor.white
        whiteCover.tag = 222
        self.viewController.view.addSubview(whiteCover)
//        UIView.animate(withDuration: 0.2) {
//            whiteCover.alpha = 0.75
//        }
        whiteCover.fadeTo(alphaValue: 0.75, duration: 0.2)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftSideMenu(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        self.viewController.view.addGestureRecognizer(tap)
    }
    
    func hideCoverWhiteView(){
        viewController.view.removeGestureRecognizer(tap)
        for subview in self.viewController.view.subviews {
            if subview.tag == 222 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }) { (finished) in
                    if finished == true {
                        subview.removeFromSuperview()
                    }
                    
                }
            }
        }
    }
    
    func showShadowForViewController(status:Bool){
        if status == true {
            viewController.view.layer.shadowOpacity = 0.5
        }else{
            viewController.view.layer.shadowOpacity = 0.0
        }
    }
    
}


private extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func leftSideMenuVC() -> LeftSideMenuVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LeftSideMenuVC") as? LeftSideMenuVC
    }
    
    class func homeVC() -> HomeVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}
