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
    
    static  func  addFireBaseDate(min: String , Type:String,place : String){
        var  id = self.getMemberId()
        if ( id == nil){
            id =  UiManager.getUUID()
        }
        let reference: DatabaseReference! = Database.database().reference().child("MemberList").child(id as! String)
        let childRef = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        let dateReviewReference = reference.child(DateManager.getDateString2())
        // 新增節點資料
        var dateReview: [String : AnyObject] = [String : AnyObject]()
        dateReview["Id"] = id as AnyObject
        dateReview["Minute"] = min  as AnyObject
        dateReview["Type"] = Type as AnyObject
        dateReview["Place"] = place as AnyObject
        
        dateReview["date"]  = DateManager.getDateforDate() as AnyObject
        dateReview["createDate"] = DateManager.getDateString2() as AnyObject
        dateReviewReference.updateChildValues(dateReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
        }
        
        
    }
    static  func SearchDatabase(){
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
                print("Min",dictionaryData["Minute"])
                print("date",dictionaryData["date"])
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
