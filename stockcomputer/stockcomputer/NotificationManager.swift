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
        
let center = UNUserNotificationCenter.current()

  let content = UNMutableNotificationContent()
        content.title = "14"
        content.body = "46"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var date = DateComponents()
        date.month = 9
        date.day = 30
        date.hour = 14
        date.minute = 46
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
        
    static func CreaeWeekdayNotification(){
        
    // 計算期指結算 日子
    let center = UNUserNotificationCenter.current()

      let content = UNMutableNotificationContent()
            content.title = "台指期結算"
            content.body = "期貨結算,波動大 請小心操作！！"
            content.categoryIdentifier = "alarm"
            content.sound = UNNotificationSound.default
        
//            var date = DateComponents()
//            date.month = 9
//            date.day = 30
//            date.hour = 14
//            date.minute = 46
//        date.weekday = 4
        var weekForMonthly = DateComponents()
        weekForMonthly.weekOfMonth = 3 // 每個月的第3週
         weekForMonthly.weekday = 4 // 週三
        weekForMonthly.hour =  08
        weekForMonthly.minute = 00
        

        let trigger = UNCalendarNotificationTrigger(dateMatching: weekForMonthly, repeats:true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            center.add(request)
        }
    
    
}
