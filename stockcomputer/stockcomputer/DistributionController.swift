//
//  DistributionController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/4/23.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class DistributionController: UIViewController ,GADBannerViewDelegate  ,UITextFieldDelegate {
    @IBOutlet weak var nowprice: UILabel!
    @IBAction func clear_btn(_ sender: Any) {
        price.text = ""
        price.placeholder = ""
        money.text = ""
        money.placeholder = ""
        son.text = ""
        son.placeholder = ""
        nowprice.text = ""
    }
    @IBOutlet weak var clear: UIButton!
    @IBAction func cal(_ sender: Any) {
        if(price.text?.count != 0){
            if(money.text?.count != 0 && son.text?.count == 0){
                cal_1()
                
            }else if (son.text?.count != 0 && money.text?.count == 0 ){
                 cal_2()
            }
            else if (money.text?.count != 0 && son.text?.count != 0){
                cal_3()
            }
        }
        
    }
    var adBannerView: GADBannerView?

    @IBOutlet weak var price: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdBanner()
        setKeyKeyboardType()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var son: UITextField!
    @IBOutlet weak var money: UITextField!
    var price_double = 0.0
    func cal_1(){
        //除息前股價＝ 現金股利  + 除權息後新股價
        price_double = Double (price.text!)! - Double(money.text!)!
        nowprice.text = String(price_double)
        son.placeholder = "0.0"
        
    }
    func cal_2(){
        //除權後股價＝ 除權前股價 ／（1＋股票股利 ÷ 10)
        price_double = Double (price.text!)! / (1 + Double(son.text!)! / 10)
        nowprice.text = String(format: "%.2f", price_double)
        money.placeholder = "0.0"

        

    }
    func cal_3(){
        //除權除息後股價＝( 除權前股價 息 - 現金股利)／（1＋股票股利 ÷ 10)
        price_double = ( Double (price.text!)! - Double(money.text!)!) / (1 + (Double(son.text!)! / 10))
        nowprice.text = String(format: "%.2f", price_double)

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
        
        price.keyboardType = UIKeyboardType.numbersAndPunctuation
        price.returnKeyType = .done
        
        money.keyboardType = UIKeyboardType.numbersAndPunctuation
        money.returnKeyType = .done
        son.keyboardType = UIKeyboardType.numbersAndPunctuation
        son.returnKeyType = .done
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
