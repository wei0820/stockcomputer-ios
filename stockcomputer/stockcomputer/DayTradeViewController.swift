//
//  DayTradeViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class DayTradeViewController: UIViewController ,GADBannerViewDelegate ,UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var buy_price: UITextField!
    @IBOutlet weak var sell_price: UITextField!
    @IBOutlet weak var buy_num: UITextField!
    
    @IBOutlet weak var label_profit: UILabel!
    @IBOutlet weak var sell_num: UITextField!
    
    @IBOutlet weak var sell_buy: UITextField!
    
    @IBAction func button_calculation(_ sender: UIButton) {
//        label_profit.text = String(pirceout)
//        print(buy_price.text)
//        print(sell_price.text)
        
        closeKeyboard()

        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return info.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return info[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedValue = pickerView.selectedRow(inComponent: 0)
        pirceout = price[selectedValue]
    }
    
    var adBannerView: GADBannerView?
    var info = [ "沒折扣", "95折","9折","85折","8折", "75折", "7折", "65折","6折", "55折", "5折","45折","4折","35折","3折", "28折","5折","2折","15折","1折","0.5折" ,"免手續費"]
    var price = [1,0.95,0.9,0.85,0.8,0.75,0.7,0.65,0.6,0.55,0.5,0.45,0.4,0.35,0.3,0.28,0.25,0.2,0.15,0.1,0.05,0]
    var pirceout = 1.0
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdBanner()
        setKeyKeyboardType()
    

    }
    func setKeyKeyboardType(){
        buy_price.keyboardType = UIKeyboardType.phonePad
        sell_price.keyboardType = UIKeyboardType.phonePad
        buy_num.keyboardType = UIKeyboardType.phonePad
        sell_num.keyboardType = UIKeyboardType.phonePad

        
    }
    func closeKeyboard(){
        self.buy_price.resignFirstResponder()
        self.sell_price.resignFirstResponder()
        
        self.buy_num.resignFirstResponder()
        self.sell_num.resignFirstResponder()
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
    
}
