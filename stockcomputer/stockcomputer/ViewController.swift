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
import MarqueeLabel
class ViewController: MGoogleADViewController,UITableViewDataSource,UITableViewDelegate,SKProductsRequestDelegate, SKPaymentTransactionObserver{
    var productIDs: [String] = [String]() // 產品ID(Consumable_Product、Not_Consumable_Product)
    var hud :JGProgressHUD?
    var selectedProductIndex: Int! // 點擊到的購買項目
    var isProgress: Bool = false // 是否有交易正在進行中
    var delegate: IAPurchaseViewControllerDelegate!
    var productsArray: [SKProduct] = [SKProduct]() //  存放 server 回應的產品項目
    
    var itemName = ["贊助開發者","現股當沖獲利計算","現股獲利計算","港股複委託購入試算","除權除息參考價試算","資券成數查詢","期貨獲利試算","選擇權獲利計算","融券獲利試算","盤中個股精選追蹤","外陸資買賣超前50名","投信買賣超前50名","自營商買賣超前50名","八大官股銀行買賣超","融資融券借券排行"]
    
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var marqueeLabel: MarqueeLabel!
    
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
            buy()
        }else if (name == itemName[1]){
            performSegue(withIdentifier: "DayTrade", sender: nil)
            
        }else if(name ==  itemName[2]){
            performSegue(withIdentifier: "TradeDetail", sender: nil)
            
        }else if(name == itemName[3]) {
            performSegue(withIdentifier: "hongkongstock", sender: nil)
        }else if (name == itemName[4]){
            performSegue(withIdentifier: "distribution", sender: nil)
            
        }else if (name == itemName[5]){
            
            performSegue(withIdentifier: "number", sender: nil)
            
        }else if (name == itemName[6]){
            
            performSegue(withIdentifier: "futures", sender: nil)
            
        }else if (name == itemName[7]){
            performSegue(withIdentifier: "sellput", sender: nil)
        }else if (name == itemName[8]){
            performSegue(withIdentifier: "Margin", sender: nil)
        }else if (name == itemName[9]){
            if(!checkIsMember()){
                         setNoLoginAlert(title: "提示", message: "請登入會員,在使用")
                         return
                     }
            performSegue(withIdentifier: "stocklist", sender: nil)

            
        }else if (name == itemName[10]){
            if(!checkIsMember()){
                setNoLoginAlert(title: "提示", message: "請登入會員,在使用")
                return
            }
            performSegue(withIdentifier: "foreigninvestment", sender: nil)
        }else if (name == itemName[11]){
            if(!checkIsMember()){
                setNoLoginAlert(title: "提示", message: "請登入會員,在使用")
                return
            }
            performSegue(withIdentifier: "trust", sender: nil)
        }else if (name == itemName[12]){
            if(!checkIsMember()){
                setNoLoginAlert(title: "提示", message: "請登入會員,在使用")
                return
            }
            performSegue(withIdentifier: "employed", sender: nil)
        }else if (name == itemName[13]){
            if(!checkIsMember()){
                setNoLoginAlert(title: "提示", message: "請登入會員,在使用")
                return
            }
            performSegue(withIdentifier: "broker", sender: nil)
        }else if (name == itemName[14]){
            if(!checkIsMember()){
                setNoLoginAlert(title: "提示", message: "請登入會員,在使用")
                return
            }
            performSegue(withIdentifier: "quotes", sender: nil)
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
        self.productIDs.append("richman")
        requestProductInfo()
        
        SKPaymentQueue.default().add(self)
        //        DateManager.addToCalendarClicked()
        marqueeLabel.type = .continuous
        marqueeLabel.speed = .duration(9)
        marqueeLabel.animationCurve = .easeInOut
        marqueeLabel.fadeLength = 10.0
        marqueeLabel.leadingBuffer = 30.0
        marqueeLabel.trailingBuffer = 20.0
        var strings = [String]()
        
        strings = [FirebaseManager.getAnnouncementSting()]
        marqueeLabel.text = strings[Int(arc4random_uniform(UInt32(strings.count)))]
   
        if(checkIsMember()){
            FirebaseManager.getMemberDate()
            FirebaseManager.setUserVersion()


        }

        
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
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count != 0 {
            print("invalidProductIdentifiers： \(response.invalidProductIdentifiers.description)")
            for product in response.products {
                self.productsArray.append(product)
                productsArray.forEach { (SKProduct) in
                }
                
                
            }
            
            //               tblProducts.reloadData()
        }
        else {
            print("There are no products.")
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("復原購買失敗...")
        print(error.localizedDescription)
        setUIAlert(title: "復原購買失敗...", message:error.localizedDescription)
    }
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        setUIAlert(title: "復原購買成功...", message: "復原購買成功")
        
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions as! [SKPaymentTransaction] {
            switch transaction.transactionState {
            case SKPaymentTransactionState.purchased:
                print("Transaction completed successfully.")
                SKPaymentQueue.default().finishTransaction(transaction)
                setUIAlert(title: "謝謝乾爹", message: "謝謝乾爹")
                print("jack",transaction.payment.productIdentifier)
                getProductIdentifier(name: transaction.payment.productIdentifier)
                
            case SKPaymentTransactionState.failed:
                print("Transaction Failed");
                print(transaction.error?.localizedDescription);
                
                SKPaymentQueue.default().finishTransaction(transaction)
                setUIAlert(title: "Transaction Failed", message: transaction.error!.localizedDescription)
                
                
            default:
                print(transaction.transactionState.rawValue)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        // 移除觀查者
        SKPaymentQueue.default().remove(self)
    }
    func getProductIdentifier(name : String){
        switch name {
        case "richman":
            break
        case "MenberPoint_1000":
            print("jack",FirebaseManager.getUserPoint())
            
            FirebaseManager.addMemberBuyPoint(pont: 1000)
            
            //1000
            break
            
        case "Member_Point_1000":
            // 500
            FirebaseManager.addMemberBuyPoint(pont: 500)
            
            break
            
        default:
            break
        }
        
    }
    func setUIAlert(title :String ,message :String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            FirebaseManager.getMemberDate()
        }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    func setNoLoginAlert(title :String ,message :String){
         let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         controller.addAction(okAction)
         present(controller, animated: true, completion: nil)
     }
    
    func buy(){
        let controller = UIAlertController(title: "商品列表", message: "請選擇要購買的商品", preferredStyle: .actionSheet)
        productsArray.forEach { (SKProduct) in
            let action = UIAlertAction(title:SKProduct.localizedTitle, style: .default) { (action) in
                if(Auth.auth().currentUser!.isAnonymous){
                    let controller = UIAlertController(title: "訪客身份", message: "您是訪客身份,雖此商品為消耗商品,但建議登入帳號再進行購買,是否能要購買", preferredStyle: .actionSheet)
                    let names = [ "是", "否"]
                    for name in names {
                        let action = UIAlertAction(title: name, style: .default) { (action) in
                            if (name == "是"){
                                if SKPaymentQueue.canMakePayments() {
                                    // 設定交易流程觀察者，會在背景一直檢查交易的狀態，成功與否會透過 protocol 得知
                                    SKPaymentQueue.default().add(self)
                                    let index = controller.actions.index(of: action)
                                    // 取得內購產品
                                    let payment = SKPayment(product: self.productsArray[index!])
                                    // 購買消耗性、非消耗性動作將會開始在背景執行(updatedTransactions delegate 會接收到兩次)
                                    SKPaymentQueue.default().add(payment)
                                    self.selectedProductIndex = controller.actions.index(of: action)
                                    
                                    
                                }
                            }else{
                                
                            }
                        }
                        controller.addAction(action)
                    }
                    let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                    controller.addAction(cancelAction)
                    self.present(controller, animated: true, completion: nil)
                }else{
                    if SKPaymentQueue.canMakePayments() {
                        // 設定交易流程觀察者，會在背景一直檢查交易的狀態，成功與否會透過 protocol 得知
                        SKPaymentQueue.default().add(self)
                        let index = controller.actions.index(of: action)
                        // 取得內購產品
                        let payment = SKPayment(product: self.productsArray[index!])
                        // 購買消耗性、非消耗性動作將會開始在背景執行(updatedTransactions delegate 會接收到兩次)
                        SKPaymentQueue.default().add(payment)}
                }
                
                
                
            }
            controller.addAction(action)
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    func requestProductInfo() {
        
        if SKPaymentQueue.canMakePayments() {
            // 取得所有在 iTunes Connect 所建立的內購項目
            let productIdentifiers: Set<String> = NSSet(array: self.productIDs) as! Set<String>
            let productRequest: SKProductsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
            
            productRequest.delegate = self
            productRequest.start() // 開始請求內購產品
            
        } else {
            print("取不到任何內購的商品...")
        }
    }
    
    
}

