//
//  DateManager.swift
//  stockcomputer
//
//  Created by oneplay on 2020/2/12.
//  Copyright © 2020 jackpan. All rights reserved.
//

import Foundation

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
    
}


