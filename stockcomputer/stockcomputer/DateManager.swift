//
//  DateManager.swift
//  stockcomputer
//
//  Created by oneplay on 2020/2/12.
//  Copyright © 2020 jackpan. All rights reserved.
//

import Foundation
import EventKit

public class DateManager{
    //计算当月天数
    public func countOfDaysInCurrentMonth() ->Int {
        
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: Date())
        return (range?.length)!
    }
    
    public static func getDateString()-> String {
        // 設定日期顯示格式
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy年MM月dd日"
        // 取得現在日期資訊
        let timeString = dateFormatter.string(from: Date())
        
        return timeString
    }
    
    public static func getDateString2()-> String {
        // 設定日期顯示格式
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        // 取得現在日期資訊
        let timeString = dateFormatter.string(from: Date())
        
        return timeString
    }
    
    public static func getDateforDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        // 取得現在日期資訊
        let timeString = dateFormatter.string(from: Date())
        return timeString
        
    }
        public static func distancesFrom(_ startingDate: Date, to resultDate: Date) -> Int {
  
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        //如果计算相差的小时数，可改为.CalendarUnitHour; day改为hour
        let comps = (gregorian as NSCalendar).components(NSCalendar.Unit.day, from: startingDate, to: resultDate, options:.wrapComponents)
        return comps.day!
    }
    
    public static func addToCalendarClicked()
        {
            let eventStore = EKEventStore()
                    
                   // 'EKEntityType.reminder' or 'EKEntityType.event'
                   eventStore.requestAccess(to: .event, completion: {
                       granted, error in
                       if (granted) && (error == nil) {
                           print("granted \(granted)")
                           print("error  \(error)")
                            
                           // 新建一个事件
                           let event:EKEvent = EKEvent(eventStore: eventStore)
                
                    
                          let dateFormatter = DateFormatter.init()
                                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss "
                    
                           event.title = "pp"
                           event.startDate = dateFormatter.date(from: "2020-03-20 00:00:00")
                           event.endDate = dateFormatter.date(from: "2020-03-20 17:50:00")
                           event.notes = "1111"
                           event.calendar = eventStore.defaultCalendarForNewEvents
                            
                           do{
                               try eventStore.save(event, span: .thisEvent)
                               print("Saved Event")
                           }catch{
                            
                        }
                            
                           // 获取所有的事件（前后90天）
                           let startDate = Date().addingTimeInterval(-3600*24*90)
                           let endDate = Date().addingTimeInterval(3600*24*90)
                           let predicate2 = eventStore.predicateForEvents(withStart: startDate,
                                                                          end: endDate, calendars: nil)
                            
                           print("查询范围 开始:\(startDate) 结束:\(endDate)")
                            
                           if let eV = eventStore.events(matching: predicate2) as [EKEvent]! {
                               for i in eV {
                                   print("标题  \(i.title)" )
                                   print("开始时间: \(i.startDate)" )
                                   print("结束时间: \(i.endDate)" )
                               }
                           }
                       }
                   })
    }
    
}


