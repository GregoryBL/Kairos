//
//  TimerSelectViewController.swift
//  Kairos
//
//  Created by Gregory Berns-Leone on 5/15/16.
//  Copyright © 2016 GregApps. All rights reserved.
//

import Cocoa

class TimerSelectViewController: NSViewController {
    
    var timer = Timer(name: "First Timer", interval: NSTimeInterval(integerLiteral: 10))
    
    @IBOutlet weak var timeRemaining: NSTextField!
    @IBOutlet weak var timeToSet: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        3
        timeRemaining.doubleValue = timer.interval
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        
        timer.interval = timeToSet.doubleValue
        timeRemaining.stringValue = timeToSet.stringValue
        
        let userInfoDict : NSDictionary = ["interval": self.timer.interval]
        NSTimer.scheduledTimerWithTimeInterval(self.timer.interval, target: self, selector: #selector(self.timerFinished(_:)), userInfo: userInfoDict, repeats: false)
    }
    
    func timerFinished(sender: AnyObject) {
        print("Timer Finished")
        let userInfoDict = (sender as! NSTimer).userInfo! as! [String: NSTimeInterval]
        let notification = NSUserNotification.init()
        notification.title = "Timer of \(userInfoDict["interval"]!) is Finished"
        notification.deliveryDate = NSDate(timeIntervalSinceNow: 0)
        NSUserNotificationCenter.defaultUserNotificationCenter().scheduleNotification(notification)
    }
}
