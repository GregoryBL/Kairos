//
//  Timer.swift
//  Kairos
//
//  Created by Gregory Berns-Leone on 5/15/16.
//  Copyright © 2016 GregApps. All rights reserved.
//

import Foundation

struct Timer {
    let name: String
    var interval: NSTimeInterval
    
    func start(sender: AnyObject) {
        NSUserNotificationCenter.defaultUserNotificationCenter()
    }
}