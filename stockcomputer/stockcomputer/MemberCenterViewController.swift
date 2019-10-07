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

class MemberCenterViewController: MUIViewController ,GADBannerViewDelegate ,GADRewardBasedVideoAdDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    var productIDs: [String] = [String]() // 產品ID(Consumable_Product、Not_Consumable_Product)
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
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    }
    override func viewWillDisappear(_ animated: Bool) {
        // 移除觀查者
        SKPaymentQueue.default().remove(self)
    }
    
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
        get()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
        self.productIDs.append("Member_Point_1000")
        requestProductInfo()
        // Do any additional setup after loading the view.
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
        
        print(bannerView.adUnitID)
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
    
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var photoimg: UIImageView!
    @IBOutlet weak var mPoint: UILabel!
    func get(){
        let firebaseAuth = Auth.auth()
        if firebaseAuth != nil {
            print(Auth.auth().currentUser?.uid)
            print( Auth.auth().currentUser?.displayName)
            print( Auth.auth().currentUser?.photoURL)
            mid.text = "會員ID:" + (Auth.auth().currentUser?.uid)!
            mName.text = "會員姓名:" + (Auth.auth().currentUser?.displayName)!
            mPoint.text = "會員點數:" + "00"
            
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
    @IBAction func shop(_ sender: Any) {
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
    @IBOutlet weak var watchVideo: NSLayoutConstraint!
    
}
