//
//  IntExt.swift
//  Challenge
//
//  Created by Felix Changoo on 11/14/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

import Foundation

extension Int {
    func getElapsedTimeReadout() -> String {
        let doubleNum = Double(self)
        let date = NSDate(timeIntervalSince1970: TimeInterval(doubleNum))
        let timeNow = NSDate()
        let elapsedInterval = timeNow.timeIntervalSince(date as Date)
        
        let ti = NSInteger(elapsedInterval)
        let hours = (ti / 3600)
        let days = (ti / 86400)
        
        var timeOutput = ""
        
        if days == 1 {
            timeOutput = "\(days) day ago"
        } else if days > 1 {
            timeOutput = "\(days) days ago"
        } else if hours == 1 {
            timeOutput = "\(hours) hour ago"
        } else {
            timeOutput = "\(hours) hours ago"
        }
        
        return timeOutput
    }
}
