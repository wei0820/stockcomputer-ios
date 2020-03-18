//
//  ViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase
import FacebookCore
import FacebookLogin
import Instabug
import JGProgressHUD

class ViewController: MGoogleADViewController,UITableViewDataSource,UITableViewDelegate{

    var itemName = ["現股當沖獲利計算","現股獲利計算","港股複委託購入試算","除權除息參考價試算","資券成數查詢","期貨獲利試算","選擇權獲利計算","融券獲利試算","盤中個股精選追蹤","外陸資買賣超前50名","投信買賣超前50名"]
    
    
    var ref: DatabaseReference!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for:indexPath)
        cell.textLabel?.text = itemName[indexPath.row]
        
        return cell
    }
    
    
    // 點選 cell 後執行的動作
    private func tableView(tableView: UITableView,
                           didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //拿到storyBoard
        let storyBoard = UIStoryboard(name: "DayTrade", bundle: nil)
        //拿到ViewController
        let nextPage = storyBoard.instantiateViewController(withIdentifier: "DayTradeController") as! DayTradeViewController
        //傳值
        //        nextPage.id = joinUsDataArray[indexPath.row].id
        //        nextPage.titleOfNavi.title = joinUsDataArray[indexPath.row].title
        //跳轉
        self.navigationController?.pushViewController(nextPage, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        tableView.deselectRow(
            at: indexPath, animated: true)
        
        let name = itemName[indexPath.row]
        Instabug.logUserEvent(withName: name)
        if (name == itemName[0]){
            performSegue(withIdentifier: "DayTrade", sender: nil)
            
        }else if(name ==  itemName[1]){
            performSegue(withIdentifier: "TradeDetail", sender: nil)
            
        }else if(name == itemName[2]) {
            performSegue(withIdentifier: "hongkongstock", sender: nil)
        }else if (name == itemName[3]){
            performSegue(withIdentifier: "distribution", sender: nil)
            
        }else if (name == itemName[4]){
            
            performSegue(withIdentifier: "number", sender: nil)
            
        }else if (name == itemName[5]){
            
            performSegue(withIdentifier: "futures", sender: nil)
            
        }else if (name == itemName[6]){
            performSegue(withIdentifier: "sellput", sender: nil)
        }else if (name == itemName[7]){
            performSegue(withIdentifier: "Margin", sender: nil)
        }else if (name == itemName[8]){
            performSegue(withIdentifier: "stocklist", sender: nil)
        }else if (name == itemName[9]){
            performSegue(withIdentifier: "foreigninvestment", sender: nil)
        }else if (name == itemName[10]){
            performSegue(withIdentifier: "trust", sender: nil)
        }
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let destVc:DayTradeViewController = segue.destination as! DayTradeViewController
        //        destVc.type = segue.identifier!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdBanner()
        setRightButton(s: "會員中心")
        setLeftButton(s: "簽到")
   
    }
    
    func setLeftButton(s: String){
        // 導覽列右邊按鈕
        
        let rightButton = UIBarButtonItem(
            title:s,
            style:.plain,
            target:self,
            action:#selector(ViewController.checkIn))
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func checkIn() {
        if(self.checkIsMember()){
            FirebaseManager.getMemberDate()
            if(FirebaseManager.getUserId() != nil && FirebaseManager.getUserPoint() != nil){
                if(FirebaseManager.getUserPoint() == 0){
                    FirebaseManager.addMemberDateToFirebase(point: 100)
                }else{
                    var point : Int = FirebaseManager.getUserPoint()
                    self.checkLoginTime()
                    FirebaseManager.getMemberDate()
                }
                
            }else{
                FirebaseManager.addMemberDateToFirebase(point: 100)
                FirebaseManager.getMemberDate()
            }
            
        }
        
    }
    
    
    
    func setRightButton(s: String){
        // 導覽列右邊按鈕
        
        let LeftButton = UIBarButtonItem(
            title:s,
            style:.plain,
            target:self,
            action:#selector(ViewController.setting))
        // 加到導覽列中
        self.navigationItem.leftBarButtonItem = LeftButton
    }
    @objc func setting() {
        
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "member")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
        
    } 
    
    func setAlert(){
        let controller = UIAlertController(title: "訪客身份", message: "請先登入再使用", preferredStyle: .actionSheet)
        let names = ["去登入"]
        for name in names {
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                if let error = error {
                    // An error happened.
                } else {
                    // Account deleted.
                }
            }
            self.userDefaults.set(nil, forKey: "userID")
            
            let action = UIAlertAction(title: name, style: .default) { (action) in
                let stroyboard = UIStoryboard(name: "Main", bundle: nil);
                let HomeVc = stroyboard.instantiateViewController(withIdentifier: "login")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate;
                appDelegate.window?.rootViewController = HomeVc
                
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
}

