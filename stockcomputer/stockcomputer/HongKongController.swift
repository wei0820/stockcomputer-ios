//
//  HongKongController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/4/19.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HongKongController: UIViewController , GADBannerViewDelegate  ,UITextFieldDelegate , GADRewardBasedVideoAdDelegate {
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
    
    @IBOutlet weak var buy_price: UITextField!
    var total = 0.0
    var handlingfee = 0.0
    var handlingfeeprice = 0
    var TransactionTax = 0.0
    var StampDuty = 0.0
    var DeliveryFee = 0.0
    var tw = 0.0
    var total_price_int = 0

    @IBOutlet weak var total_price: UILabel!
    

    
    @IBAction func cal_btn(_ sender: Any) {
        
        if(buy_price.text?.count != 0 &&  buy_num.text?.count != 0){
            total = Double(buy_price.text!)! * Double(buy_num.text!)!
            if(TF1_1.text?.count != 0 ){
                handlingfee = Double(TF1_1.text!)! * 0.01

            }else{
                handlingfee = Double(TF1_1.placeholder!)! * 0.01

            }
            handlingfeeprice = lround( total * handlingfee)
            if(TF_2.text?.count != 0 ){
                TransactionTax = total * Double(TF_2.text!)! * 0.01

            }else{
                TransactionTax = total * Double(TF_2.placeholder!)! * 0.01

            }
            if(TF_3.text?.count != 0 ){
                StampDuty = total * Double(TF_3.text!)! * 0.01

            }else{
                StampDuty = total * Double(TF_3.placeholder!)! * 0.01

            }
            if(TF_4.text?.count != 0 ){
                DeliveryFee = total * Double(TF_4.text!)! * 0.01

            }else{
                DeliveryFee = total * Double(TF_4.placeholder!)! * 0.01

            }
            if(tf_5.text?.count != 0){
                tw =  Double (tf_5.text!)!
            }else {
                tw =  Double (tf_5.placeholder!)!

            }
            
            if(total * handlingfee<=100){
                handlingfeeprice = 100
                lb_1.text = "手續費:" + String(handlingfeeprice)

            }else{
                lb_1.text = "手續費:" + String(handlingfeeprice  )

            }
            
            lb2.text = "交易稅:"  + String(TransactionTax )
            lb3.text = "印花稅:" + String(StampDuty )
            lb4.text = "交割費:" + String(DeliveryFee )
            total_price.text = "總價:" + String( lround (total ) + handlingfeeprice + lround(TransactionTax) + lround(StampDuty) + lround( DeliveryFee ))
            total_price_int = lround (total ) + handlingfeeprice + lround(TransactionTax) + lround(StampDuty) + lround( DeliveryFee )
            tw_lb.text = "台幣約:" + String(total_price_int * lround(tw))
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            }
        }
    }
    @IBOutlet weak var buy_num: UITextField!
    @IBOutlet weak var TF1_1: UITextField!
    @IBOutlet weak var TF_2: UITextField!
    @IBOutlet weak var TF_3: UITextField!
    @IBOutlet weak var TF_4: UITextField!
    var adBannerView: GADBannerView?

    @IBOutlet weak var lb4: UILabel!
    @IBOutlet weak var lb_1: UILabel!
    @IBOutlet weak var lb3: UILabel!
    @IBOutlet weak var tw_lb: UILabel!
    @IBOutlet weak var lb2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdBanner()
        // Do any additional setup after loading the view.
        
        setTF_1()
        setTF_2()
        setTF_3()
        setTF_4()
        setTF_5()
        setKeyKeyboardType()

        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3940256099942544/1712485313")

    }
    @IBOutlet weak var tf_5: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case TF1_1 :
            TF1_1.resignFirstResponder()

            UserDefaults.standard.set(TF1_1.text, forKey:"TF_1")

            break
        case TF_2 :
            TF_2.resignFirstResponder()

            UserDefaults.standard.set(TF_2.text, forKey:"TF_2")

            break
        case TF_3 :
            TF_3.resignFirstResponder()

            UserDefaults.standard.set(TF_3.text, forKey:"TF_3")

            break
        case TF_4 :
            TF_4.resignFirstResponder()

            UserDefaults.standard.set(TF_4.text, forKey:"TF_4")

            break
        case tf_5 :
            tf_5.resignFirstResponder()

            UserDefaults.standard.set(tf_5.text, forKey:"tf_5")

            break
        case buy_price :
            buy_price.resignFirstResponder()

            break
        case buy_num :
            buy_num.resignFirstResponder()
            break
        default:
            textField.resignFirstResponder()

        }
        
        return true
    }
    
    func setTF_1(){
        
        if let TF_1 = UserDefaults.standard.object(forKey: "TF_1") as? String {
            
            TF1_1.placeholder = TF_1
            TF1_1.text = ""
        }else{
            TF1_1.placeholder = "0.25"

        }

    }
    func setTF_2(){
        
        if let TF_22 = UserDefaults.standard.object(forKey: "TF_2") as? String {
            
            TF_2.placeholder = TF_22
            TF_2.text = ""

        }else{
            TF_2.placeholder = "0.0027"
            
        }
        
    }
    func setTF_3(){
        
        if let TF_33 = UserDefaults.standard.object(forKey: "TF_3") as? String {
            
            TF_3.placeholder = TF_33
            TF_3.text = ""

        }else{
            TF_3.placeholder = "0.1"
            
        }
        
    }
    func setTF_4(){
        
        if let TF_44 = UserDefaults.standard.object(forKey: "TF_4") as? String {
            
            TF_4.placeholder = TF_44
            TF_4.text = ""

        }else{
            TF_4.placeholder = "0.005"
            
        }
        
    }
    func setTF_5(){
        
        if let tf_55 = UserDefaults.standard.object(forKey: "tf_5") as? String {
            
            tf_5.placeholder = tf_55
            tf_5.text = ""

        }else{
            tf_5.placeholder = "4"
            
        }
        
    }
    func setAdBanner(){
        let id = "ca-app-pub-7019441527375550/9487446087"
        adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView!.adUnitID = id
        adBannerView!.delegate = self
        adBannerView!.rootViewController = self
        
        adBannerView!.load(GADRequest())
        
    }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setKeyKeyboardType(){
        
        buy_num.keyboardType = UIKeyboardType.numbersAndPunctuation
        buy_num.returnKeyType = .done
        
        buy_price.keyboardType = UIKeyboardType.numbersAndPunctuation
        buy_price.returnKeyType = .done
        TF1_1.keyboardType = UIKeyboardType.numbersAndPunctuation
        TF1_1.returnKeyType = .done

        TF_2.keyboardType = UIKeyboardType.numbersAndPunctuation
        TF_2.returnKeyType = .done
        TF_3.keyboardType = UIKeyboardType.numbersAndPunctuation
        TF_3.returnKeyType = .done
        TF_4.keyboardType = UIKeyboardType.numbersAndPunctuation
        TF_4.returnKeyType = .done
        
        tf_5.keyboardType = UIKeyboardType.numbersAndPunctuation
        tf_5.returnKeyType = .done
        
    }
    
    func closeKeyboard(){
        self.buy_price.resignFirstResponder()
        self.buy_num.resignFirstResponder()
        self.TF1_1.resignFirstResponder()
        self.TF_2.resignFirstResponder()
        self.TF_3.resignFirstResponder()
        self.TF_4.resignFirstResponder()
        self.tf_5.resignFirstResponder()

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}