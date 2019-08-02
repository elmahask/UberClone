//
//  DataServices.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/25/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE_URL : DatabaseReference = Database.database().reference()

class DataServices {
    public static let instance = DataServices()
    
    private init(){}
    
    private var _REF_BASE_URL = DB_BASE_URL
    private var _REF_UERS_URL = DB_BASE_URL.child("Users")
    private var _REF_DRIVERS_URL = DB_BASE_URL.child("Drivers")
    private var _REF_TRIPS_URL = DB_BASE_URL.child("Trips")
    
    var REF_UERS_URL : DatabaseReference {
        return _REF_UERS_URL
    }
    
    var REF_DRIVERS_URL : DatabaseReference {
        return _REF_DRIVERS_URL
    }
    
    var REF_TRIPS_URL : DatabaseReference {
        return _REF_TRIPS_URL
    }
    
    func createFirebaseDBUser( uid : String, userData: Dictionary<String,Any> ) {
        REF_UERS_URL.child(uid).setValue(userData)
    }
    
    func createFirebaseDBDriver( uid : String, driverData : Dictionary<String,Any> ) {
        REF_DRIVERS_URL.child(uid).setValue(driverData)
    }
    
}
