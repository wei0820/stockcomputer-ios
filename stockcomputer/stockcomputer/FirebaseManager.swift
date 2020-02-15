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
                  print("当前时间的时间戳：\(timeStamp)")
                
//                var dateString = dateFormatter.string(from: (Auth.auth().currentUser?.metadata.lastSignInDate)!)
                
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
                var id : String = dictionaryData["id"] as! String
                var name : String = dictionaryData["name"] as! String
                var lastlogintime : Int = dictionaryData["lastlogintime"] as! Int
                var point : Int = dictionaryData["point"] as! Int
                userDefaults.set(id, forKey: "id")
                userDefaults.set(name, forKey: "name")
                userDefaults.set(lastlogintime, forKey: "lastlogintime")
                userDefaults.set(point, forKey: "point")
                print("member",id)
                print("member",name)
                print("member",lastlogintime)
                print("member",point)

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
        return 0
    
    }
    
    
    static  func  addMemberTimeAndPintToFirebase(){
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
        dateReview["lastlogintime"]  = getLastLoginTime() as AnyObject
        dateReview["point"] = addPoint   as AnyObject
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
}

