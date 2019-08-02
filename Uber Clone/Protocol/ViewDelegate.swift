//
//  ViewDelegate.swift
//  Uber Clone
//
//  Created by Wael M Elmahask on 7/24/19.
//  Copyright © 2019 Wael M Elmahask. All rights reserved.
//

import UIKit

protocol ViewDelegate {
    func toggleLeftSideMenu()
    func addLeftSideMenuVC()
    func animateLeftSideMenu(shouldExpand:Bool)
}
