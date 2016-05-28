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
    
    var currentTimer: Timer?
    var timeRemaining : NSTimeInterval? {
        
        didSet {
            if timeRemaining != nil {
                timeRemainingMessage.stringValue = "Time Remaining: \(Int(timeRemaining!)) seconds"
            } else {
                timeRemainingMessage.stringValue = "How long should the timer be?"
            }
        }
    }
    
    @IBAction func makeNewTimer(sender: NSButton) {
        
        currentTimer = Timer(name: self.nameToSet.stringValue, interval: self.timeToSet.doubleValue, startTime: NSDate())
    }
    
    @IBAction func startTimer(sender: NSButton) {
        
        if let timer = currentTimer?.copyTimer() {
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
        notification.title = "Timer of \(Int((sender.userInfo as! Timer).interval)) is Finished"
        notification.deliveryDate = NSDate()
        NSUserNotificationCenter.defaultUserNotificationCenter().scheduleNotification(notification)
    }
}










