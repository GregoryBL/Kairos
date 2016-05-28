//
//  NSDate_extend.swift
//  Kairos
//
//  Created by Gregory Berns-Leone on 5/27/16.
//  Copyright © 2016 GregApps. All rights reserved.
//

import Cocoa

extension NSDate {
    
    func offsetFrom(date:NSDate) -> NSTimeInterval {
        let difference = NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: [])
        
        return Double(difference.second)
    }
    
    func stringWithOffsetFrom(date:NSDate) -> String {
        
        let dayHourMinuteSecond: NSCalendarUnit = [.Day, .Hour, .Minute, .Second]
        let difference = NSCalendar.currentCalendar().components(dayHourMinuteSecond, fromDate: date, toDate: self, options: [])
        
        let seconds = "\(difference.second)s"
        let minutes = "\(difference.minute)m" + " " + seconds
        let hours = "\(difference.hour)h" + " " + minutes
        let days = "\(difference.day)d" + " " + hours
        
        if difference.day    > 0 { return days }
        if difference.hour   > 0 { return hours }
        if difference.minute > 0 { return minutes }
        if difference.second > 0 { return seconds }
        return ""
    }
    
}