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
import LLCycleScrollView
class ViewController: MGoogleADViewController,SKProductsRequestDelegate,SKPaymentTransactionObserver,UITabBarDelegate{
    
    @IBOutlet weak var FinancingView: UIView!
    @IBOutlet weak var MarginView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var paymeView: UIView!
    @IBOutlet weak var bannerView: LLCycleScrollView!
    @IBOutlet weak var mOtherView: UIView!
    
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var CurrentPrice: UIView!
    var productIDs: [String] = [String]() // 產品ID(Consumable_Product、Not_Consumable_Product)
    var hud :JGProgressHUD?
    var selectedProductIndex: Int! // 點擊到的購買項目
    var isProgress: Bool = false // 是否有交易正在進行中
    var delegate: IAPurchaseViewControllerDelegate!
    var productsArray: [SKProduct] = [SKProduct]() //  存放 server 回應的產品項目
    
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var marqueeLabel: MarqueeLabel!
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            setJump(type: "DayTrade")
            
            
            break
        case 2:
            setJump(type: "sellput")
            
        
            break
        case 3:
            
            setJump(type: "futures")
            
            break
        case 4:
            setToast(s: "下個版本推出")
            break
            
        default:
            
            break
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAdBanner()
        
        
        setBannerView()
        setUIView()
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
            
            if(!FirebaseManager.getVersion().isEmpty){
                var newVersion : Double = FirebaseManager.getNewVersion() as! Double
                var userVersion : Double = Double(FirebaseManager.getVersion()) as! Double
                if(userVersion < newVersion){
                    setAlert(title: "版本過舊", message: "請您至 App Store 更新 ")
                }
                
            }
            
        }
        
    
        
    }
    func setBannerView(){
        self.bannerView.imagePaths = FirebaseManager.getPageArray()
        self.bannerView.imageViewContentMode = .scaleToFill
        self.bannerView.customPageControlStyle = .image
        self.bannerView.pageControlPosition = .center
        // 是否对url进行特殊字符处理
        self.bannerView.isAddingPercentEncodingForURLString = true
        self.bannerView.pageControlCurrentPageColor = .white
        bannerView.customPageControlInActiveTintColor = .white

        
        // 2018-02-25 新增协议
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
    func setAlert(title :String ,message :String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
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
        }
    }
    
    
    
    func setUIView(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.CurrentPrice.addGestureRecognizer(gesture)
        
        let payme = UITapGestureRecognizer(target: self, action:  #selector(self.paymeAction))
        self.paymeView.addGestureRecognizer(payme)
        
        let news = UITapGestureRecognizer(target: self, action:  #selector(self.newsAction))
        self.newsView.addGestureRecognizer(news)
        
        
        let tomorrow = UITapGestureRecognizer(target: self, action:  #selector(self.tomorrowAction))
        self.todayView.addGestureRecognizer(tomorrow)
        
        let margin = UITapGestureRecognizer(target: self, action:  #selector(self.marginAction))
            self.MarginView.addGestureRecognizer(margin)
        let other = UITapGestureRecognizer(target: self, action:  #selector(self.otherAction))
                 self.mOtherView.addGestureRecognizer(other)
        
        let financing = UITapGestureRecognizer(target: self, action:  #selector(self.financingAction))
        self.FinancingView.addGestureRecognizer(financing)
        
    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        setJump(type: "CurrentPrice")
    }
    
    @objc func paymeAction(sender : UITapGestureRecognizer) {
        // Do what you want
        buy()
    }
    @objc func newsAction(sender : UITapGestureRecognizer) {
         setJump(type: "news")
      }
    @objc func tomorrowAction(sender : UITapGestureRecognizer) {
       setJump(type: "tomorrow")
    }
    @objc func marginAction(sender : UITapGestureRecognizer) {
        setJump(type: "margin")
     }
    
    @objc func otherAction(sender : UITapGestureRecognizer) {
           setJump(type: "other")
        }
    
    @objc func financingAction(sender : UITapGestureRecognizer) {
             setJump(type: "financing")
          }
    
}

