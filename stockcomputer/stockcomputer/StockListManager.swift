//
//  StockListManager.swift
//  stockcomputer
//
//  Created by  JackPan on 2021/5/29.
//  Copyright © 2021 jackpan. All rights reserved.
//

import Foundation
import Firebase
class StockListManger{
    static  func getStockdividendlist(){
        print("StockListManger","getStockcomuperAllDate")
        Database.database().reference().child("stockdividendlist" as! String).observe(.childAdded, with: {
            (snapshot) in
            // childAdded逐筆呈現
            if let dictionaryData = snapshot.value as? [String: AnyObject]{
                
                var number : String = dictionaryData["代號"] as! String
                print("StockListManger",number)

            }
            
        }, withCancel: nil)
    }
}
