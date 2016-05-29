//
//  TimerSelectViewController.swift
//  Kairos
//
//  Created by Gregory Berns-Leone on 5/15/16.
//  Copyright © 2016 GregApps. All rights reserved.
//

import Cocoa

class TimerSelectViewController: NSViewController {
    
    @IBOutlet weak var timeRemainingMessage: NSTextField!
    @IBOutlet weak var timeToSet: NSTextField!
    @IBOutlet weak var nameToSet: NSTextField!
    
    var timers: [Timer?] = []
    var currentTimer: Int?
    var timeRemaining : NSTimeInterval? {
        // If timeRemaining is set, update the timeRemainingMessage
        didSet {
            if timeRemaining != nil {
                timeRemainingMessage.stringValue = "Time Remaining: \(Int(timeRemaining!)) seconds"
            } else {
                timeRemainingMessage.stringValue = "How long should the timer be?"
            }
        }
    }
    
    // Put new timer in timer array and update the number of the current one
    @IBAction func makeNewTimer(sender: NSButton) {
        
        timers.append(Timer(name: self.nameToSet.stringValue, interval: self.timeToSet.doubleValue, startTime: NSDate()))
        
        if currentTimer != nil {
            currentTimer = currentTimer! + 1
        } else {
            currentTimer = 0
        }
    }
    
    // TODO: Should take an index for the timer array so it can start any one
    @IBAction func startTimer(sender: NSButton) {
        
        if let cur = currentTimer, timer = timers[cur]?.copyTimer() {
            timer.startTime = NSDate()
            
            NSTimer.scheduledTimerWithTimeInterval(timer.interval,
                                                   target: self,
                                                   selector: #selector(self.timerFinished(_:)),
                                                   userInfo: timer,
                                                   repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(0.5,
                                                   target: self,
                                                   selector: #selector(self.updateTimeLeft(_:)),
                                                   userInfo: timer,
                                                   repeats: true)
        } else {
            timeRemainingMessage.stringValue = "No Timers defined in that position"
        }
    }
    
    func updateTimeLeft(sender: NSTimer) {
        
        let timer = (sender.userInfo! as! Timer)
        if (timer.interval - NSDate().offsetFrom(timer.startTime)) > 0 {
            timeRemaining = timer.interval - NSDate().offsetFrom(timer.startTime)
        } else {
            timeRemaining = nil
            sender.invalidate()
        }
        
    }
    
    func timerFinished(sender: NSTimer) {

        let notification = NSUserNotification.init()
        notification.title = "Timer of \(Int((sender.userInfo as! Timer).interval)) seconds is Finished"
        notification.deliveryDate = NSDate()
        NSUserNotificationCenter.defaultUserNotificationCenter().scheduleNotification(notification)
    }
}










