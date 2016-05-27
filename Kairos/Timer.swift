//
//  Timer.swift
//  Kairos
//
//  Created by Gregory Berns-Leone on 5/15/16.
//  Copyright © 2016 GregApps. All rights reserved.
//

import Foundation

class Timer: NSObject {
    let name: String
    let interval: NSTimeInterval
    let startTime: NSDate
    
    init(name: String, interval: NSTimeInterval, startTime: NSDate) {
        self.name = name
        self.interval = interval
        self.startTime = startTime
    }
}