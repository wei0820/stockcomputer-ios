//
//  TimerManager.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/31.
//  Copyright © 2019 jackpan. All rights reserved.
//

import Foundation
class TimerManager{
    //１．取得當下時間戳
    static func getTime() -> Int{
        let now:Date = Date()

        let timeInterval:TimeInterval = now.timeIntervalSince1970

        let time:Int = Int(timeInterval)

        print("現在時間的時間戳：\(time)") // 現在時間的時間戳：1517211263
        return time
    }
    //２．取得當下時間 UTC
    static func getNowTime() -> String{
        // 獲取當前時間

        let now:Date = Date()

        // 建立時間格式

        let dateFormat:DateFormatter = DateFormatter()

        dateFormat.dateFormat = "MM/dd"

        // 將當下時間轉換成設定的時間格式

        let dateString:String = dateFormat.string(from: now)

        print("現在時間：\(dateString)") // 現在時間：2018年01月29日 15:34:23
        
        return dateString
    }
    //3．時間戳轉時間格式

    static func timeStampToDate(timestamp :Int) -> String{
        // 將時間戳轉換成日期

        let timeStamp:Int = timestamp

        let timeInterval:TimeInterval = TimeInterval(timeStamp)

        let date:Date = Date(timeIntervalSince1970: timeInterval)

        let dateFormat:DateFormatter = DateFormatter()

        dateFormat.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        var dateSting = dateFormat.string(from: date)
        

        print("\(timeStamp)：\(dateSting)")
        return dateSting
    }
    
}
