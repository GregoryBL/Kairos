//
//  AppDelegate.swift
//  Kairos
//
//  Created by Gregory Berns-Leone on 5/15/16.
//  Copyright © 2016 GregApps. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var eventMonitor: EventMonitor?

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
    let popover = NSPopover()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "AlarmClock_black")
            button.action = #selector(AppDelegate.togglePopover(_:))
        }
        
        popover.contentViewController = TimerSelectViewController(nibName: "TimerSelectViewController", bundle: nil)
        
        eventMonitor = EventMonitor(mask: ( NSEventMask.LeftMouseDownMask.union(NSEventMask.RightMouseDownMask) ))  { [unowned self] event in
            if self.popover.shown {
                self.hidePopover(event)
            }
        }
        eventMonitor?.start()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
        eventMonitor?.start()
    }
    
    func hidePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func togglePopover(sender: AnyObject) {
        if popover.shown {
            self.hidePopover(sender)
        } else {
            self.showPopover(sender)
        }
    }
}

