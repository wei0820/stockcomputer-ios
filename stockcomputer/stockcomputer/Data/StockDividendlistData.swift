//
//  StockDividendlistData.swift
//  stockcomputer
//
//  Created by  JackPan on 2021/5/29.
//  Copyright © 2021 jackpan. All rights reserved.
//

import Foundation
import Firebase

class StockDividendlistData{
    
        var rank : String = ""
        var number : String = ""
        var name : String = ""
        var deal : String = ""
        var eps : String = ""
        var year : String =  ""
        var money : String = ""
        var stock : String = ""
        var totaldividend : String = ""
        var cashyield : String = ""
        var stockyield : String = ""
        var totalyieldrate : String = ""
        var earningscouponrate : String = ""
        var earningsallotmentratio : String = ""
        var totalsurplusdistributionratio : String = ""
    
      init(snapshot: DataSnapshot) {
        let snapshotValue: [String: AnyObject] = snapshot.value as! [String: AnyObject]
        self.rank = snapshotValue["排名"] as! String
        self.number = snapshotValue["代號"] as! String
        self.name = snapshotValue["名稱"] as! String
        self.deal = snapshotValue["成交"] as! String
        self.eps = snapshotValue["所屬EPS"] as! String
        self.year = snapshotValue["股利發放年度"] as! String
        self.money = snapshotValue["現金股利"] as! String
        self.stock = snapshotValue["股票股利"] as! String
        self.totaldividend = snapshotValue["合計股利"] as! String
        self.cashyield = snapshotValue["現金殖利率"] as! String
        self.stockyield = snapshotValue["股票殖利率"] as! String
        self.totalyieldrate = snapshotValue["合計殖利率"] as! String
        self.earningscouponrate = snapshotValue["盈餘配息率"] as! String
        self.earningsallotmentratio = snapshotValue["盈餘配股率"] as! String
        self.totalsurplusdistributionratio = snapshotValue["盈餘總分配率"] as! String
    }
    
}
