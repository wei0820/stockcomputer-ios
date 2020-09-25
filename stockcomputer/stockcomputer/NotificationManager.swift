//
//  NotificationManager.swift
//  stockcomputer
//
//  Created by oneplay on 2020/9/14.
//  Copyright © 2020 jackpan. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager{
    
    static func CreateNotification(title :String,subtitle:String,body:String){
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    static func CreateDateNotification(){
        
//        var dateComponents = DateComponents()
//        dateComponents.
//
//
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: <#T##DateComponents#>, repeats: <#T##Bool#>)
    }
    
    
    
}
