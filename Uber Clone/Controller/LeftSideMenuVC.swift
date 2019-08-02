//
//  LeftSideMenuVC.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/24/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit
import Firebase

class LeftSideMenuVC: UIViewController {
    
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var pickupModeLbl: UILabel!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var accountTypeLbl: UILabel!
    @IBOutlet weak var loginOutBtn: UIButton!
    let currentUserId = Auth.auth().currentUser?.uid
    let appDelegate = AppDelegate.getAppDelegate()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pickupModeSwitch.isOn = false
        pickupModeSwitch.isHidden = true
        pickupModeLbl.isHidden = true
        
        observePassengerOrDriver()
        
        if self.currentUserId == nil {
            emptyField()
        }else{
            userEmailLbl.text = Auth.auth().currentUser?.email
            accountTypeLbl.text = ""
            userImageView.isHidden = false
            loginOutBtn.setTitle("LogOut", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func observePassengerOrDriver(){
        DataServices.instance.REF_UERS_URL.observeSingleEvent(of: .value, with: { (dataSnapshot) in
            if let snapshot = dataSnapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == self.currentUserId {
                        self.accountTypeLbl.text = "PASSENGER"
                    }
                }
            }
        })
        
        
        DataServices.instance.REF_DRIVERS_URL.observeSingleEvent(of: .value, with: { (dataSnapshot) in
            if let snapshot = dataSnapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == self.currentUserId {
                        self.accountTypeLbl.text = "DRIVER"
                        self.pickupModeSwitch.isHidden = false
                        self.pickupModeLbl.isHidden = false
                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                    }
                }
            }
        })
    }
    
    private func emptyField(){
        userEmailLbl.text = ""
        userImageView.isHidden = true
        accountTypeLbl.text = ""
        loginOutBtn.setTitle("Sing Up / Login", for: .normal)
    }

    @IBAction func paymentBtnPressed(_ sender: Any) {
    }
    
    @IBAction func tripsBtnPressed(_ sender: Any) {
    }
    
    @IBAction func helpBtnPressed(_ sender: Any) {
    }
    
    @IBAction func settingBtnPressed(_ sender: Any) {
    }
    
    @IBAction func switchBtnToggled(_ sender: UISwitch) {
        if sender.isOn {
            pickupModeLbl.text = "Pickup Mode Enabled"
            appDelegate.menuContainerVC.toggleLeftSideMenu()
            pickupModeSwitched(enaled: true)
        }else{
            pickupModeLbl.text = "Pickup Mode Disabled"
            appDelegate.menuContainerVC.toggleLeftSideMenu()
            pickupModeSwitched(enaled: false)
        }
        
    }
    
    private func pickupModeSwitched(enaled:Bool){
        print("switch \(enaled)")
        DataServices.instance.REF_DRIVERS_URL.child(currentUserId!).updateChildValues(["isPickupModeEnabled" : enaled])
    }
    
    @IBAction func authorizedBtn(_ sender: Any) {
        if self.currentUserId == nil {
            let storyboard = UIStoryboard(name: "Authorization", bundle: Bundle.main)
            let authorizedVC = storyboard.instantiateViewController(withIdentifier: "AuthorizedVC") as? AuthorizedVC
            present(authorizedVC!,animated: true,completion: nil)
        }else{
            do{
                try Auth.auth().signOut()
                emptyField()
            }catch (let error){
                print(error.localizedDescription)
            }
        }
    }
}
