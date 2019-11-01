//
//  MemberCenterViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/7.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import FacebookLogin
import FacebookCore
import Firebase
import StoreKit
import JGProgressHUD

class MemberCenterViewController: MUIViewController ,GADBannerViewDelegate ,GADRewardBasedVideoAdDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    var productIDs: [String] = [String]() // 產品ID(Consumable_Product、Not_Consumable_Product)
    var hud :JGProgressHUD?
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var rewardbtn: UIButton!
    @IBOutlet weak var shopbtn: UIButton!
    var productsArray: [SKProduct] = [SKProduct]() //  存放 server 回應的產品項目
    var selectedProductIndex: Int! // 點擊到的購買項目
    var isProgress: Bool = false // 是否有交易正在進行中
    var delegate: IAPurchaseViewControllerDelegate!
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
        hud?.dismiss(afterDelay: 3.0)
        
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
    
    @IBOutlet weak var lasttime: UILabel!
    @IBAction func back(_ sender: Any) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
        
    }
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad has completed.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }
    var adBannerView: GADBannerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAdBanner()
        shopbtn.isHidden = false
        rewardbtn.isHidden = true
        
        get()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
        //        self.productIDs.append("Member_Point_1000")
        //        self.productIDs.append("MenberPoint_1000")
        self.productIDs.append("richman")
        
        requestProductInfo()
        
        SKPaymentQueue.default().add(self)
        
        // Do any additional setup after loading the view.
    }
    func requestProductInfo() {
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = "Loading"
        hud?.show(in: self.view)
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
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    func setAdBanner(){
        let id = "ca-app-pub-7019441527375550/2358814075"
        adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView!.adUnitID = id
        adBannerView!.delegate = self
        adBannerView!.rootViewController = self
        
        adBannerView!.load(GADRequest())
    }
    @IBAction func restart(_ sender: Any) {
        let controller = UIAlertController(title: "復原購買", message: "是否復原購買?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { (_) in
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        
    }
    /*
     
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    // Called when an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
        
    }
    
    // Called when an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print((error.localizedDescription))
    }
    
    // Called just before presenting the user a full screen view, such as a browser, in response to
    // clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before dismissing a full screen view.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just after dismissing a full screen view.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before the application will background or terminate because the user clicked on an
    // ad that will launch another application (such as the App Store).
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print(#function)
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
        ])
    }
    @IBAction func about(_ sender: Any) {
        let controller = UIAlertController(title: "會員點數", message: "用於一些需要的地方！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
        
    }
    @IBOutlet weak var mid: UILabel!
    
    @IBAction func logout(_ sender: Any) {
        userDefaults.set(nil, forKey: "userID")
        
        
        //   123456
        //
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "login")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
        
    }
    
    
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var photoimg: UIImageView!
    @IBOutlet weak var mPoint: UILabel!
    func get(){
        let firebaseAuth = Auth.auth()
        if firebaseAuth != nil {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var dateString = dateFormatter.string(from: (Auth.auth().currentUser?.metadata.lastSignInDate)!)
            lasttime.text = "最後登入時間:" + dateString
            if(firebaseAuth.currentUser!.isAnonymous){
                mid.text = "會員ID:" + "遊客身份"
                mName.text = "會員姓名:" + "遊客身份"
                mPoint.text = "會員點數:"+"遊客身份"
            }else{
                
                
                mid.text = "會員ID:" + (Auth.auth().currentUser?.uid)!
                mName.text = "會員姓名:" + (Auth.auth().currentUser?.displayName)!
                mPoint.text = "會員點數:"
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData:NSData = NSData(contentsOf: (Auth.auth().currentUser?.photoURL)!)!
                    // When from background thread, UI needs to be updated on main_queue
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData as Data)
                        self.photoimg.image = image
                    }
                }
                
            }
        }
        
    }
    var mTitle :String = ""
    @IBAction func shop(_ sender: Any) {
        let controller = UIAlertController(title: "商品列表", message: "請點選商品進行購買", preferredStyle: .actionSheet)
        productsArray.forEach { (SKProduct) in
            let action = UIAlertAction(title:"小額贊助開發者", style: .default) { (action) in
                if(Auth.auth().currentUser!.isAnonymous){
                    let controller = UIAlertController(title: "訪客身份", message: "您是訪客身份,雖此商品為消耗商品,但能建議登入帳號再進行購買,是否能要購買", preferredStyle: .actionSheet)
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
                                    SKPaymentQueue.default().add(payment)}
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
    @IBAction func watch(_ sender: Any) {
        
        let controller = UIAlertController(title: "觀看影片", message: "是否觀看影片來得到點數", preferredStyle: .actionSheet)
        let names = [ "是", "否"]
        for name in names {
            let action = UIAlertAction(title: name, style: .default) { (action) in
                if (name == "看影片集點數"){
                    if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                        GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
                    }
                }else{
                    
                }
            }
            controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    func setUIAlert(title :String ,message :String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
}
