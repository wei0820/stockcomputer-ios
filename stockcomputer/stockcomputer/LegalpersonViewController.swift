//
//  LegalpersonViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/6/5.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Kanna
import Alamofire
import JGProgressHUD
class LegalpersonViewController: UIViewController,GADBannerViewDelegate {
    var adBannerView: GADBannerView?
    var hud :JGProgressHUD?
    @IBOutlet weak var label_buy: UILabel!
    @IBOutlet weak var label_sell: UILabel!
    
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var label_3: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = "Loading"
        hud?.show(in: self.view)
        setAdBanner()
          getStock(url: "https://www.wantgoo.com/stock/twstock/threeall")

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var label_5: UILabel!
    @IBOutlet weak var label_4: UILabel!
    
    @IBOutlet weak var label2_1: UILabel!
    
    @IBOutlet weak var label2_2: UILabel!
    @IBOutlet weak var label2_3: UILabel!
    @IBOutlet weak var label3_1: UILabel!
    @IBOutlet weak var label3_2: UILabel!
    @IBOutlet weak var label3_3: UILabel!
    @IBOutlet weak var label4_1: UILabel!
    @IBOutlet weak var label4_2: UILabel!
    @IBOutlet weak var label4_3: UILabel!
    @IBOutlet weak var label5_1: UILabel!
    @IBOutlet weak var label5_2: UILabel!
    @IBOutlet weak var label5_3: UILabel!
    @IBOutlet weak var label5: UILabel!
    var buy :Double  = 0.0
    var buy_1 :Double = 0.0
    var buy_2 :Double = 0.0
    var buy_3 :Double = 0.0
    var buy_4 :Double = 0.0
    var buy_5 :Double = 0.0

    var sell :Double = 0.0
    var sell_1 :Double = 0.0
    var sell_2 :Double = 0.0
    var sell_3 :Double = 0.0
    var sell_4 :Double = 0.0
    var sell_5 :Double = 0.0

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
    @objc func getStock(url : String){
        Alamofire.request(url).responseString { response in
            if let html = response.result.value {
                self.parseHTML(url: html)
            }
        }
        
    }
    func select(Label : UILabel,s :String,isbuy : Bool,istotal :Bool){
      
        if(!isbuy){
            if(istotal){
                if( s.hasPrefix("-")){
                    
                    Label.textColor = UIColor.green
                    
                    
                }else{
                    Label.textColor = UIColor.red
                    
                    
                }
            }else{
                Label.textColor = UIColor.green

            }
       
            Label.text = s + "(億)"


        }else{
            Label.textColor = UIColor.red
            Label.text = s + "(億)"
        }
 

    }
    func parseHTML(url: String ) {
        ////tbody[class='tb-stock tb-link']|//tbody|//tr|//td
        ////*[@id='fm']/div[4]/div[8]/div[1]/div/div/table/tbody/tr[2]
        if let doc = try? Kanna.HTML(html: url, encoding: String.Encoding.utf8) {
            
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/caption") {
                print()
                label_1.text = rate.text!

//                select(Label: label_1, s: rate.text!,isdate: false)
            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[1]/td[2]") {
                label_2.textColor = UIColor.red
                label_2.text = rate.text! + "(億)"
                buy_1 = Double(rate.text!)!
            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[1]/td[3]") {
                label_3.textColor = UIColor.green
                label_3.text = rate.text! + "(億)"
                sell_1 = Double(rate.text!)!

            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[1]/td[4]") {
                if(rate.text!.hasPrefix("-")){
                    
                    label_4.textColor = UIColor.green
                    label_4.text = rate.text! + "(億)"

                    
                }else{
                    label_4.textColor = UIColor.red
                    label_4.text = "+" + rate.text! + "(億)"

                    
                }
            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[2]/td[2]") {
                label2_1.textColor = UIColor.red
                label2_1.text = rate.text! + "(億)"
                buy_2 = Double(rate.text!)!

            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[2]/td[3]") {
                label2_2.textColor = UIColor.green
                label2_2.text = rate.text! + "(億)"
                sell_2 = Double(rate.text!)!

            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[2]/td[4]") {
                if(rate.text!.hasPrefix("-")){
                    
                    label2_3.textColor = UIColor.green
                    label2_3.text = rate.text! + "(億)"

                    
                }else{
                    label2_3.textColor = UIColor.red
                    label2_3.text = "+" + rate.text! + "(億)"

                    
                }
            }
            
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[3]/td[2]") {
                label3_1.textColor = UIColor.red
                label3_1.text = rate.text! + "(億)"
                buy_3 = Double(rate.text!)!

            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[3]/td[3]") {
                label3_2.textColor = UIColor.green
                label3_2.text = rate.text! + "(億)"
                sell_3 = Double(rate.text!)!

            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[3]/td[4]") {
                if(rate.text!.hasPrefix("-")){
                    
                    label3_3.textColor = UIColor.green
                    label3_3.text = rate.text! + "(億)"

                    
                }else{
                    label3_3.textColor = UIColor.red
                    label3_3.text = "+" + rate.text! + "(億)"

                    
                }
            }
            
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[4]/td[2]") {
                label4_1.textColor = UIColor.red
                label4_1.text = rate.text! + "(億)"
                buy_4 = Double(rate.text!)!
                

            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[4]/td[3]") {
                label4_2.textColor = UIColor.green
                label4_2.text = rate.text! + "(億)"
                sell_4 = Double(rate.text!)!

            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[4]/td[4]") {
                if(rate.text!.hasPrefix("-")){
                    
                    label4_3.textColor = UIColor.green
                    label4_3.text = rate.text! + "(億)"

                    
                }else{
                    label4_3.textColor = UIColor.red
                    label4_3.text = "+" + rate.text! + "(億)"

                    
                }
            }
            
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[5]/td[2]") {
                label5_1.textColor = UIColor.red
                label5_1.text = rate.text! + "(億)"
                buy_5 = Double(rate.text!)!

            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[5]/td[3]") {
                label5_2.textColor = UIColor.green
                label5_2.text = rate.text! + "(億)"
                sell_5 = Double(rate.text!)!

            }
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[5]/td[4]") {
                if(rate.text!.hasPrefix("-")){
                    
                    label5_3.textColor = UIColor.green
                    label5_3.text = rate.text! + "(億)"

                    
                }else{
                    label5_3.textColor = UIColor.red
                    label5_3.text = "+" + rate.text! + "(億)"

                    
                }
            }
            
            for rate in doc.xpath("//*[@id='sideCol']/div/table[1]/tbody/tr[6]/td[2]") {
                if(rate.text!.hasPrefix("-")){
                    
                    label5.textColor = UIColor.green
                    label5.text = rate.text! + "(億)"

                    
                }else{
                    label5.textColor = UIColor.red
                    label5.text = "+" +  rate.text! + "(億)"

                    
                }
            }
            buy = buy_1 + buy_2 + buy_3 + buy_4 + buy_5
            sell = sell_1 + sell_2 + sell_3 + sell_4 + sell_5
            
            label_buy.text = String(Double(round(1000*buy)/1000)) + "(億)"
            label_buy.textColor = UIColor.red

            label_sell.text = String(Double(round(1000*sell)/1000)) + "(億)"
            label_sell.textColor = UIColor.green


            hud?.dismiss()
            
            
            
        }
    }
}

