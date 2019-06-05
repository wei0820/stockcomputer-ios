//
//  StockPriceViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/5/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Kanna
import Alamofire
import JGProgressHUD

class StockPriceViewController: UIViewController ,GADBannerViewDelegate {
    var adBannerView: GADBannerView?
    var timer: Timer?
    var hud :JGProgressHUD?
    @IBAction func now(_ sender: Any) {
        getAll()
    }
    @IBOutlet weak var vl9_4: UILabel!
    @IBOutlet weak var vl9_1: UILabel!
    @IBOutlet weak var vl9_2: UILabel!
    @IBOutlet weak var vl9_3: UILabel!
    @IBOutlet weak var vl7_4: UILabel!
    @IBOutlet weak var vl7_3: UILabel!
    @IBOutlet weak var vl7_2: UILabel!
    @IBOutlet weak var vl7_1: UILabel!
    @IBOutlet weak var vl6_1: UILabel!
    @IBOutlet weak var vl6_4: UILabel!
    @IBOutlet weak var vl8_2: UILabel!
    @IBOutlet weak var vl10_1: UILabel!
    @IBOutlet weak var vl10_3: UILabel!
    
    @IBOutlet weak var vl10_4: UILabel!
    @IBOutlet weak var vl10_2: UILabel!
    @IBOutlet weak var vl8_4: UILabel!
    @IBOutlet weak var vl8_3: UILabel!
    @IBOutlet weak var vl8_1: UILabel!
    @IBOutlet weak var vl6_3: UILabel!
    @IBOutlet weak var vl6_2: UILabel!
    @IBOutlet weak var vl5_4: UILabel!
    @IBOutlet weak var vl5_3: UILabel!
    @IBOutlet weak var vl5_2: UILabel!
    @IBOutlet weak var vl5_1: UILabel!
    @IBOutlet weak var vl4_4: UILabel!
    @IBOutlet weak var vl4_3: UILabel!
    @IBOutlet weak var vl4_2: UILabel!
    @IBOutlet weak var vl4_1: UILabel!
    @IBOutlet weak var vl3_4: UILabel!
    @IBOutlet weak var vl3_3: UILabel!
    @IBOutlet weak var vl3_2: UILabel!
    @IBOutlet weak var vl3_1: UILabel!
    @IBOutlet weak var vl2_4: UILabel!
    @IBOutlet weak var vl2_3: UILabel!
    @IBOutlet weak var vl2_2: UILabel!
    @IBOutlet weak var vl2_1: UILabel!
    @IBOutlet weak var yr_1: UILabel!
    @IBOutlet weak var yr2: UILabel!
    @IBOutlet weak var yr3: UILabel!
    @IBOutlet weak var yr4: UILabel!
    @IBOutlet weak var oil1: UILabel!
    @IBOutlet weak var oil2: UILabel!
    @IBOutlet weak var oil3: UILabel!
    @IBOutlet weak var oil4: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdBanner()
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = "Loading"
        hud?.show(in: self.view)
        getAll()
        getStock(url: "https://www.wantgoo.com/stock/twstock/threeall")
        
//
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(StockPriceViewController.getAll), userInfo: nil, repeats: true)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        // 將timer的執行緒停止
        if self.timer != nil {
            self.timer?.invalidate()
        }
    }
    
    @IBOutlet weak var min1: UILabel!
    @IBOutlet weak var min2: UILabel!
    @IBOutlet weak var min3: UILabel!
    @IBOutlet weak var min4: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setAdBanner(){
        let id = "ca-app-pub-7019441527375550/9487446087"
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
    
    
    //
    @objc func getStockPrice(url : String,textName : UILabel,textprice : UILabel ,textchg : UILabel,textNow :UILabel){
        Alamofire.request(url).responseString { response in
            if let html = response.result.value {
                self.parseTaiwanBankHTML(url: html,textName: textName,textprice: textprice,textchg: textchg,textNow: textNow)
            }
        }
        
    }
    @objc func getStock(url : String){
        Alamofire.request(url).responseString { response in
            if let html = response.result.value {
                self.parseHTML(url: html)
            }
        }
        
    }
    
    func parseHTML(url: String ) {
        ////tbody[class='tb-stock tb-link']|//tbody|//tr|//td
        ////*[@id='fm']/div[4]/div[8]/div[1]/div/div/table/tbody/tr[2]
        if let doc = try? Kanna.HTML(html: url, encoding: String.Encoding.utf8) {

            for rate in doc.xpath("//*[@id='container']/div[6]/table[1]/thead/tr[1]/th[2]") {

                
            }
            
            
          
            
        }
    }
    func parseTaiwanBankHTML(url: String,textName : UILabel,textprice : UILabel ,textchg : UILabel,textNow :UILabel ) {
        //        print ("url", url)
        ////tbody[class='tb-stock tb-link']|//tbody|//tr|//td
        ////*[@id='fm']/div[4]/div[8]/div[1]/div/div/table/tbody/tr[2]
        if let doc = try? Kanna.HTML(html: url, encoding: String.Encoding.utf8) {
            
            for rate in doc.xpath("//*[@id='topBasic']/div[2]/div[1]/span[3]") {
                
                textchg.text = "漲跌:" +  rate.text!
                if( rate.text!.hasPrefix("-")){
                    
                    textchg.textColor = UIColor.green
                    textprice.textColor = UIColor.green
                    textNow.textColor = UIColor.green
                }else{
                    textchg.textColor = UIColor.red
                    textprice.textColor = UIColor.red
                    textNow.textColor = UIColor.red
                    
                }
                
            }
            
            
            for rate in doc.xpath("//*[@id='topBasic']/div[1]/h3") {
                
                textName.text = rate.text!
                
            }
            for rate in doc.xpath("//*[@id='topBasic']/div[2]/div[1]/span[1]") {
                
                textprice.text = "成交:" + rate.text!
            }
      
            for rate in doc.xpath("//*[@id='topBasic']/div[2]/div[1]/span[2]") {
                
                textNow.text = "幅度:" + rate.text!

                
            }
            
        }
    }
    @objc func getAll(){
        
        getStockPrice(url: "https://www.wantgoo.com/global/stockindex?StockNo=B1YM%26",textName: self.min1,textprice: self.min2,textchg: self.min3,textNow: self.min4)
        getStockPrice(url: "https://www.wantgoo.com/global/stockindex?stockno=DJI",textName: self.vl2_1,textprice: self.vl2_2,textchg: self.vl2_3,textNow: self.vl2_4)
        getStockPrice(url: "https://www.wantgoo.com/global/stockindex?stockno=SOX", textName: vl3_1, textprice: vl3_4, textchg: vl3_2, textNow: vl3_3)
        getStockPrice(url: "https://www.wantgoo.com/global/stockindex?stockno=NAS", textName: vl4_1, textprice: vl4_2, textchg: vl4_3, textNow: vl4_4)
        getStockPrice(url: "https://www.wantgoo.com/global/stockindex?stockno=SP5", textName: vl5_1, textprice: vl5_2, textchg: vl5_3, textNow: vl5_4)
        getStockPrice(url: "https://www.wantgoo.com/global/stockindex?stockno=VIX", textName: vl6_1, textprice: vl6_2, textchg: vl6_3, textNow: vl6_4)
        getStockPrice(url: "https://www.wantgoo.com/option/futures/quotes?StockNo=WSPM%26", textName: vl7_1, textprice: vl7_2, textchg: vl7_3, textNow: vl7_4)
        getStockPrice(url:"https://www.wantgoo.com/global/stockindex?stockno=S2TWZ1", textName: vl8_1, textprice: vl8_2, textchg: vl8_3, textNow: vl8_4)
        getStockPrice(url: "https://www.wantgoo.com/global/stockindex?stockno=USDTWD", textName: vl9_1, textprice: vl9_2, textchg: vl9_3, textNow: vl9_4)
        getStockPrice(url: "https://www.wantgoo.com/global/stockindex?stockno=GOLD", textName: vl10_4, textprice: vl10_1, textchg: vl10_2, textNow: vl10_3)
        
        
                getStockPrice(url: "https://www.wantgoo.com/global/stockindex?stockno=OIL", textName: oil4, textprice: oil1, textchg: oil2, textNow: oil3)
                getStockPrice(url: "https://www.wantgoo.com/global/stockindex?stockno=US10-YR", textName: yr4, textprice: yr_1, textchg: yr2, textNow: yr3)
        hud?.dismiss(afterDelay: 3.0)

        
    }
}
