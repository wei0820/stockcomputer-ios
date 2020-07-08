//
//  FirebaseManager.swift
//  stockcomputer
//
//  Created by oneplay on 2020/2/12.
//  Copyright © 2020 jackpan. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class FirebaseManager {
    static let userDefaults = UserDefaults.standard
    
    static func getMemberId () -> String{
        let firebaseAuth = Auth.auth()
        if firebaseAuth != nil {
            if(!firebaseAuth.currentUser!.isAnonymous){
                
                return  (Auth.auth().currentUser?.uid)!
            }
            
            return ""
            
        }
        return ""
    }
    static func getMemberName () -> String{
        let firebaseAuth = Auth.auth()
        if firebaseAuth != nil {
            if(!firebaseAuth.currentUser!.isAnonymous){
                
                return  (Auth.auth().currentUser?.displayName)!
            }
            
            return ""
            
        }
        return ""
    }
    static func getLastLoginTime() -> Int{
        let firebaseAuth = Auth.auth()
        if firebaseAuth != nil {
            if(!firebaseAuth.currentUser!.isAnonymous){
                //yyyy年MM月dd日
                let now = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                //当前时间的时间戳
                let timeInterval:TimeInterval = now.timeIntervalSince1970
                let timeStamp = Int(timeInterval)
                return timeStamp
            }
            return 0
            
        }
        return 0
        
        
    }
    
    static  func  addMemberDateToFirebase(point :Int ){
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        let reference: DatabaseReference! = Database.database().reference().child("MemberList").child(id as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(id)
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        dateReview["id"] = id as AnyObject
        dateReview["name"] = getMemberName()  as AnyObject
        dateReview["lastlogintime"]  = getLastLoginTime() as AnyObject
        dateReview["point"] = point   as AnyObject
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
    static  func getMemberDate(){
        
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        
        // 查詢節點資料
        Database.database().reference().child("MemberList").child(id as! String).observe(.childAdded, with: {
            (snapshot) in
            
            // childAdded逐筆呈現
            if let dictionaryData = snapshot.value as? [String: AnyObject]{
                var id : String = ""
                var name : String = ""
                var lastlogintime : Int = 0
                var point : Int = dictionaryData["point"] as! Int
                var watchadtime :Int = 0
                var version :String = ""
                if( dictionaryData["id"]  != nil){
                    id =  dictionaryData["id"] as! String
                             
                         }
                if( dictionaryData["name"]  != nil){
                     name =  dictionaryData["name"] as! String
                             
                         }
                if( dictionaryData["lastlogintime"]  != nil){
                       lastlogintime =  dictionaryData["lastlogintime"] as! Int
                             
                         }
                if( dictionaryData["watchadtime"]  != nil){
                             watchadtime =  dictionaryData["watchadtime"] as! Int
                             
                         }
                if( dictionaryData["watchadtime"]  != nil){
                    watchadtime =  dictionaryData["watchadtime"] as! Int
                    
                }
                if( dictionaryData["version"]  != nil){
                    version =  dictionaryData["version"] as! String
                    
                }
                userDefaults.set(id, forKey: "id")
                userDefaults.set(name, forKey: "name")
                userDefaults.set(lastlogintime, forKey: "lastlogintime")
                userDefaults.set(point, forKey: "point")
                userDefaults.set(watchadtime, forKey: "watchadtime")
                userDefaults.set(version, forKey: "version")
   

            }
            
        }, withCancel: nil)
        
        
    }
    
    static  func DeleteDatabase(){
        // 刪除節點資料
        
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        Database.database().reference().child("MemberList").child(id as! String).removeValue { (error, ref) in
            if error != nil{
                print(error!)
                return
            }
            print("remove data success...")
            
        }
    }
    
    
    /// get member  information
    
    static func getUserId() ->String{
        if(userDefaults.value(forKey: "id") != nil){
            return userDefaults.value(forKey: "id")! as! String
        }
        return ""
        
    }
    static func getUserName() ->String{
        if(userDefaults.value(forKey: "name") != nil){
            return userDefaults.value(forKey: "name")! as! String
        }
        return ""
        
    }
    static func getUserLlastlogintime() ->Int{
        if(userDefaults.value(forKey: "lastlogintime") != nil){
            return userDefaults.value(forKey: "lastlogintime")! as! Int
        }
        return 0
        
    }
    static func getUserPoint() ->Int{
        if(userDefaults.value(forKey: "point") != nil){
            return userDefaults.value(forKey: "point")! as! Int
        }
        return 100
        
    }
    static func getUserWatchTime() ->Int{
        if(userDefaults.value(forKey: "watchadtime") != nil){
            return userDefaults.value(forKey: "watchadtime")! as! Int
        }
        return 0
        
    }
    
    static func getAnnouncementSting() ->String{
        if(userDefaults.value(forKey: "announcement") != nil){
            return userDefaults.value(forKey: "announcement")! as! String
        }
        return "暫時無公告"
        
    }
    
    static func getIsCheckVersion() ->Int{
         
         if(userDefaults.value(forKey: "isCheckVersion") != nil){
             return userDefaults.value(forKey: "isCheckVersion")! as! Int
         }
         return 0
         
     }
     
    static func getVersion() ->String{

        if(userDefaults.value(forKey: "version") != nil){
            return userDefaults.value(forKey: "version")! as! String
        }
        return ""

    }
    static func getNewVersion() ->Double{
         
         if(userDefaults.value(forKey: "newVersion") != nil){
             return userDefaults.value(forKey: "newVersion")! as! Double
         }
        return 0.0
         
     }
    
    
    
    static  func  addMemberTimeAndPintToFirebase(timestamp :Int){
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        let reference: DatabaseReference! = Database.database().reference().child("MemberList").child(id as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(id)
        var point :Int = getUserPoint()
        var addPoint : Int = point + 100
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        dateReview["id"] = id as AnyObject
        dateReview["name"] = getMemberName()  as AnyObject
        dateReview["lastlogintime"]  = timestamp  as AnyObject
        dateReview["point"] = addPoint   as AnyObject
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
    
    
    static  func  setUserVersion(){
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        
        let reference: DatabaseReference! = Database.database().reference().child("MemberList").child(id as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(id)
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        if(getVersion().isEmpty){
            let dictionary = Bundle.main.infoDictionary!
            let app_version = dictionary["CFBundleShortVersionString"] as! String
            dateReview["version"] = app_version  as AnyObject
            
        }else{
            let dictionary = Bundle.main.infoDictionary!
            let app_version = dictionary["CFBundleShortVersionString"] as! String
            var userDouble :Double  = Double(getVersion()) as! Double
            let newDouble  :Double  = Double(app_version)  as! Double
      

            if(userDouble < newDouble){

                dateReview["version"] = app_version  as AnyObject

            }else{

                dateReview["version"] = getVersion()  as AnyObject

            }
            
            
        }
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
    
    
    static  func  addWatchADTimeToFirebase(watchTime : Int){
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        let reference: DatabaseReference! = Database.database().reference().child("MemberList").child(id as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(id)
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        dateReview["id"] = id as AnyObject
        dateReview["name"] = getMemberName()  as AnyObject
        dateReview["lastlogintime"]  =  getUserLlastlogintime() as AnyObject
        dateReview["point"] = getUserPoint()   as AnyObject
        dateReview["watchadtime"] = watchTime as AnyObject
        
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
    
    static  func  addMemberWatchAdFirebase(pont :Int){
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        let reference: DatabaseReference! = Database.database().reference().child("MemberList").child(id as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(id)
        var point :Int = getUserPoint()
        var addPoint : Int = point + 100
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        dateReview["id"] = id as AnyObject
        dateReview["name"] = getMemberName()  as AnyObject
        dateReview["lastlogintime"]  = getUserLlastlogintime()  as Any as AnyObject
        dateReview["point"] = pont   as Any as AnyObject
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
    
    static  func  addMemberBuyPoint(pont :Int){
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        let reference: DatabaseReference! = Database.database().reference().child("MemberList").child(id as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(id)
        var point :Int = getUserPoint()
        var addPoint : Int = point + pont
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        dateReview["id"] = id as AnyObject
        dateReview["name"] = getMemberName()  as AnyObject
        dateReview["lastlogintime"]  = getUserLlastlogintime()  as AnyObject
        dateReview["point"] = addPoint   as AnyObject
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
    static  func getStockcomuperAllDate(){
        Database.database().reference().child("stockcomuper").child("stockcomuper" as! String).observe(.childAdded, with: {
            (snapshot) in
            // childAdded逐筆呈現
            if let dictionaryData = snapshot.value as? [String: AnyObject]{
                var announcement : String = dictionaryData["announcement"] as! String
                var isCheckVersion : Int = dictionaryData["isCheckVersion"] as! Int
                var newVersion : Double = dictionaryData["newVersion"] as! Double
                userDefaults.set(announcement, forKey: "announcement")
                userDefaults.set(isCheckVersion, forKey: "isCheckVersion")
                userDefaults.set(newVersion, forKey: "newVersion")

                
            }
            
        }, withCancel: nil)
    }
    static  func  addMember(month :String){
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        let reference: DatabaseReference! = Database.database().reference().child("Profit").child(id as! String).child("04")
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(month)
        var point :Int = getUserPoint()
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        dateReview["month"] = "11111111" as AnyObject
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
    
    
    static  func getMemberMonthDate(){
        
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        
        // 查詢節點資料
        Database.database().reference().child("Profit").child(id as! String).child("04").observe(.childAdded, with: {
            (snapshot) in
            
            // childAdded逐筆呈現
            if let dictionaryData = snapshot.value as? [String: AnyObject]{
                var month : String = dictionaryData["month"] as! String
            }
            
        }, withCancel: nil)
        
        
    }
    
    static  func getBannerDate(){
        var array = Array<String>()
        array.removeAll()
        Database.database().reference().child("banner").child("banner" as! String).observe(.childAdded, with: {
            (snapshot) in
            // childAdded逐筆呈現
            if let dictionaryData = snapshot.value as? [String: AnyObject]{
                var page1 : String = dictionaryData["page1"] as! String
                var page2 : String = dictionaryData["page2"] as! String
                var page3 : String = dictionaryData["page3"] as! String
                var page4 : String = dictionaryData["page4"] as! String
                var page5 : String = dictionaryData["page5"] as! String
                array.append(page1)
                array.append(page2)
                array.append(page3)
                array.append(page4)
                array.append(page5)
                userDefaults.set(array, forKey: "page")
                
            }
            
        }, withCancel: nil)
    }
    
    static func getPageArray() ->Array<String>{

        if(userDefaults.value(forKey: "page") != nil){
            return userDefaults.array(forKey: "page")! as! [String]
        }
        return [
            "http://www.g-photography.net/file_picture/3/3587/4.jpg",
            "http://img2.zjolcdn.com/pic/0/13/66/56/13665652_914292.jpg",
            "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
        ]

    }
    // 設定 事件
    static func setAnalytics(title:String){
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemName: title,
        ])
    }
    
    static  func  setPhoneMember(id :String){
        var point :Int = getUserPoint()
        let reference: DatabaseReference! = Database.database().reference().child("MemberList").child(id as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(id)
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        dateReview["id"] = id as AnyObject
        dateReview["lastlogintime"]  = getLastLoginTime() as AnyObject
        dateReview["point"] = point   as AnyObject
        
          if(getVersion().isEmpty){
              let dictionary = Bundle.main.infoDictionary!
              let app_version = dictionary["CFBundleShortVersionString"] as! String
              dateReview["version"] = app_version  as AnyObject
              
          }else{
              let dictionary = Bundle.main.infoDictionary!
              let app_version = dictionary["CFBundleShortVersionString"] as! String
              var userDouble :Double  = Double(getVersion()) as! Double
              let newDouble  :Double  = Double(app_version)  as! Double
        

              if(userDouble < newDouble){

                  dateReview["version"] = app_version  as AnyObject

              }else{

                  dateReview["version"] = getVersion()  as AnyObject

              }
              
              
          }
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
    
    //設定 庫存股票
    static  func  setStockPrice(id :String,date :String){
        var point :Int = getUserPoint()
        let reference: DatabaseReference! = Database.database().reference().child("StockPrice").child(id as! String).child(date as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(id)
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        dateReview["id"] = id as AnyObject
        dateReview["lastlogintime"]  = getLastLoginTime() as AnyObject
        dateReview["point"] = point   as AnyObject
        
          if(getVersion().isEmpty){
              let dictionary = Bundle.main.infoDictionary!
              let app_version = dictionary["CFBundleShortVersionString"] as! String
              dateReview["version"] = app_version  as AnyObject
              
          }else{
              let dictionary = Bundle.main.infoDictionary!
              let app_version = dictionary["CFBundleShortVersionString"] as! String
              var userDouble :Double  = Double(getVersion()) as! Double
              let newDouble  :Double  = Double(app_version)  as! Double
        

              if(userDouble < newDouble){

                  dateReview["version"] = app_version  as AnyObject

              }else{

                  dateReview["version"] = getVersion()  as AnyObject

              }
              
              
          }
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
}

