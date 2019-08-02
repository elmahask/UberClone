//
//  AuthManager.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/26/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import Foundation
import Firebase

class AuthManager {
    
    
    class func signInOrCreateUser(email: String, password: String, isDriver:Bool, completionHandler: @escaping (_ success: Bool) -> Void) {
        singIn(email: email, password: password) { (isSigned) in
            print("isSigned \(isSigned)")
            if !isSigned {
                createUser(email: email, password: password, isDriver: isDriver) { (isCreated) in
                    print("isCreated \(isCreated)")
                    completionHandler(isCreated)
                }
            }
            completionHandler(isSigned)
        }
    }
    
    private class func singIn (email: String, password: String, completionHandler: @escaping (_ success: Bool) -> Void){
        // [START headless_email_auth]
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            // [START_EXCLUDE]
            if let error = error {
                print(AuthManager.showError(error: error))
                print(error.localizedDescription)
                completionHandler(false)
                return
            }else{
                completionHandler(true)
            }
            // [END headless_email_auth]
        }
    }
    
    private class func createUser (email: String, password: String, isDriver:Bool, completionHandler: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let user = authResult?.user {
                 print(user.uid)
                if isDriver {
                     let userData = ["providerID":user.providerID,"isDriver":true,"isPickupModeEnabled":false,"driverIsOnTrip":false] as [String : Any]
                    DataServices.instance.createFirebaseDBDriver(uid: user.uid, driverData:userData )
                }else{
                    DataServices.instance.createFirebaseDBUser(uid: user.uid, userData:["providerID":user.providerID])
                }
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    private class func showError (error:Error) -> String {
        switch AuthErrorCode(rawValue: error._code){
        case .wrongPassword? :
            return "\(error.localizedDescription)"
        case .emailAlreadyInUse? :
            return "\(error.localizedDescription)"
        case .invalidEmail? :
            return "\(error.localizedDescription)"
        default:
            return "an unexpected error occurred. please try again"
            
        }
    }
    
}
