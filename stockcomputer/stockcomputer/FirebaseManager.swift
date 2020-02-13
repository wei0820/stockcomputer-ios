//
//  FirebaseManager.swift
//  stockcomputer
//
//  Created by oneplay on 2020/2/12.
//  Copyright © 2020 jackpan. All rights reserved.
//

import Foundation
import Foundation
import Firebase

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
    static func getLastLoginTime() -> String{
        let firebaseAuth = Auth.auth()
        if firebaseAuth != nil {
            if(!firebaseAuth.currentUser!.isAnonymous){
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                var dateString = dateFormatter.string(from: (Auth.auth().currentUser?.metadata.lastSignInDate)!)
                
                return dateString
            }
            return ""
            
        }
        return ""
        
        
    }
    
    static  func  addMemberDateToFirebase(point :String ){
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        let reference: DatabaseReference! = Database.database().reference().child("MemberList").child(id as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(DateManager.getDateString2())
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
    static  func SearchMemberDate(){
        var minarray =  Array<String>()
        var dateArray = Array<String>()
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        // 查詢節點資料
        Database.database().reference().child("MemberList").child(id as! String).observe(.childAdded, with: {
            (snapshot) in
            // childAdded逐筆呈現
            if let dictionaryData = snapshot.value as? [String: AnyObject]{
                minarray.append(dictionaryData["Minute"] as! String)
                dateArray.append(dictionaryData["date"] as! String)
                
                
            }
            userDefaults.set(minarray, forKey: "minArray")
            userDefaults.set(dateArray, forKey: "dateArray")
            
            
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
}
