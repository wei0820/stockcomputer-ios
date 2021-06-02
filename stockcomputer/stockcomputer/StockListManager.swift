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
    static  func getStockdividendlist() -> Array<StockDividendlistData>{
        var StockDividendlistDataArray  = Array<StockDividendlistData>()
        
        Database.database().reference().child("stockdividendlist" as! String).observe(.childAdded, with: {
            (snapshot) in
            // childAdded逐筆呈現
            if let dictionaryData = snapshot.value as? [String: AnyObject]{
                var rank : String = dictionaryData["排名"] as! String
                var number : String = dictionaryData["代號"] as! String
                var name : String = dictionaryData["名稱"] as! String
                var deal : String = dictionaryData["成交"] as! String
                var eps : String = dictionaryData["所屬EPS"] as! String
                var year : String = dictionaryData["股利發放年度"] as! String
                var money : String = dictionaryData["現金股利"] as! String
                var stock : String = dictionaryData["股票股利"] as! String
                var totaldividend : String = dictionaryData["合計股利"] as! String
                var cashyield : String = dictionaryData["現金殖利率"] as! String
                var stockyield : String = dictionaryData["股票殖利率"] as! String
                var totalyieldrate : String = dictionaryData["合計殖利率"] as! String
                var earningscouponrate : String = dictionaryData["盈餘配息率"] as! String
                var earningsallotmentratio : String = dictionaryData["盈餘配股率"] as! String
                var totalsurplusdistributionratio : String = dictionaryData["盈餘總分配率"] as! String
                
                

            }
            
        }, withCancel: nil)
        return StockDividendlistDataArray
    }
    
}
