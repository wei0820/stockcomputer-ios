//
//  ShareStockItem.swift
//  stockcomputer
//
//  Created by oneplay on 2020/7/21.
//  Copyright © 2020 jackpan. All rights reserved.
//

import Foundation
import Firebase

struct ShareStockItem {
    var id :String
    var message :String
    var name :String
    var number :String
    var url :String
    var url_2 :String
    var url_3 :String
    var uuid : String
    var date : String
    var like :String
    var unlike :String
    var usermessage :String
    
    init(snapshot: DataSnapshot) {
        print(snapshot)
        // 取出snapshot的值(JSON)
        
        let snapshotValue: [String: AnyObject] = snapshot.value as! [String: AnyObject]
        self.id = snapshotValue["id"] as! String
        self.message = snapshotValue["message"] as! String
        self.name = snapshotValue["name"] as! String
        self.number = snapshotValue["number"] as! String
        self.url = snapshotValue["url"] as! String
        self.url_2 = snapshotValue["url_2"] as! String
        self.url_3 = snapshotValue["url_3"] as! String
        self.uuid = snapshotValue["uuid"] as! String
        self.date = snapshotValue["date"] as! String
        self.like = snapshotValue["like"] as! String
        self.unlike = snapshotValue["unlike"] as! String
        self.usermessage = snapshotValue["usermessage"] as! String


    }


    
}
