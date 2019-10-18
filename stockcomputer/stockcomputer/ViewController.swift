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
class ViewController: MGoogleADViewController,UITableViewDataSource,UITableViewDelegate{
    //    var itemName = ["現股當沖獲利計算","現股獲利計算","融資獲利計算","融券獲利計算","港股複委託購入試算","港股複委託獲利試算"]
    //    var itemName = ["現股當沖獲利計算","現股獲利計算"]
//    var itemName = ["現股當沖獲利計算","現股獲利計算","港股複委託購入試算","除權除息參考價試算","即時股價","三大法人買賣超","選擇權賣賣試算"]
//    var itemName = ["現股當沖獲利計算","現股獲利計算","港股複委託購入試算","除權除息參考價試算","即時股價","三大法人買賣超"]
    var itemName = ["現股當沖獲利計算","現股獲利計算","港股複委託購入試算","除權除息參考價試算","即時股價","三大法人買賣超","推薦營業員","資券成數查詢"]

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
        //        print(name)
        //
        //        if interstitial.isReady {
        //            interstitial.present(fromRootViewController: self)
        //        } else {
        //            print("Ad wasn't ready")
        //        }
        if (name == itemName[0]){
            performSegue(withIdentifier: "DayTrade", sender: nil)
            
        }else if(name ==  itemName[1]){
            performSegue(withIdentifier: "TradeDetail", sender: nil)
            
        }else if(name == itemName[2]) {
            performSegue(withIdentifier: "hongkongstock", sender: nil)
        }else if (name == itemName[3]){
            performSegue(withIdentifier: "distribution", sender: nil)
            
        }else if (name == itemName[4]){
            performSegue(withIdentifier: "stockprice", sender: nil)
            
            //        }else if(name == itemName[5]){
            //            performSegue(withIdentifier: "everyday", sender: nil)
            //
        }else if (name == itemName[5]){
            performSegue(withIdentifier: "Legalperson", sender: nil)
        
        }else if (name == itemName[6]){
            performSegue(withIdentifier: "map", sender: nil)

        }else if(name == itemName[7]){
            performSegue(withIdentifier: "number", sender: nil)
        }
        
        //        }else if (name ==  itemName[2]){
        //            performSegue(withIdentifier: "Financing", sender: nil)
        //
        //        }else if(name ==  itemName[3]){
        //            performSegue(withIdentifier: "Margin", sender: nil)
        //
        //        }else{
        //            performSegue(withIdentifier: "hongkong", sender: nil)
        //
        //        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let destVc:DayTradeViewController = segue.destination as! DayTradeViewController
        //        destVc.type = segue.identifier!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        setAdBanner()
        if((userDefaults.value(forKey: "userID")) != nil){
            setRightButton(s: "訪客")
            
        }else{
            setRightButton(s: "會員中心")
            
        }
     CalculationManager.getPrice(s: "2404")
        //        setInterstitial()
        //        ref = Database.database().reference()
        //        self.ref.child("users").child("11111").setValue(["username": "1111"])
        //
        //        let url = URL(string: "https://drive.google.com/open?id=1-gCzQU9bTdRf98kRyIl-EtfkwtrvmkIU")
        //        if UIApplication.shared.canOpenURL(url!) {
        //            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        //            //If you want handle the completion block than
        //            UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
        //                print("Open url : \(success)")
        //            })
        //        }
        
    }
    
    func setRightButton(s: String){
        // 導覽列右邊按鈕
        
        let rightButton = UIBarButtonItem(
            title:s,
            style:.plain,
            target:self,
            action:#selector(ViewController.setting))
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    @objc func setting() {
        var isAnonymous = userDefaults.value(forKey: "userID")
        if((isAnonymous) != nil){
            setAlert()
            return
            
        }
//        let loginManager = LoginManager()
//        loginManager.logOut()
        
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

