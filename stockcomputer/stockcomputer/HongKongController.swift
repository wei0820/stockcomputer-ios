//
//  HongKongController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/4/19.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HongKongController: UIViewController , GADBannerViewDelegate  ,UITextFieldDelegate {
    @IBOutlet weak var buy_price: UITextField!
    var total = 0.0
    var handlingfee = 0.0
    @IBAction func cal_btn(_ sender: Any) {
        
        if(buy_price.text?.count != 0 || buy_num.text?.count != 0){
            total = Double(buy_price.text!)! * Double(buy_num.text!)!
            handlingfee = Double(TF1_1.placeholder!)! * 0.01
            print(handlingfee)

            lb_1.text = "手續費:" + String( total * handlingfee )
            
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

    }
    @IBOutlet weak var tf_5: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TF1_1.resignFirstResponder()
        UserDefaults.standard.set(TF1_1.placeholder, forKey:"TF_1")
        TF_2.resignFirstResponder()
        UserDefaults.standard.set(TF_2.placeholder, forKey:"TF_2")
        TF_3.resignFirstResponder()
        UserDefaults.standard.set(TF_3.placeholder, forKey:"TF_3")
        TF_4.resignFirstResponder()
        UserDefaults.standard.set(TF_4.placeholder, forKey:"TF_4")
        tf_5.resignFirstResponder()
        UserDefaults.standard.set(tf_5.placeholder, forKey:"tf_5")
        
        return true
    }
    func setTF_1(){
        
        if let name = UserDefaults.standard.object(forKey: "TF_1") as? String {
            
            TF1_1.placeholder = name
        }else{
            TF1_1.placeholder = "0.25"

        }

    }
    func setTF_2(){
        
        if let name = UserDefaults.standard.object(forKey: "TF_2") as? String {
            
            TF_2.placeholder = name
        }else{
            TF_2.placeholder = "0.0027"
            
        }
        
    }
    func setTF_3(){
        
        if let name = UserDefaults.standard.object(forKey: "TF_3") as? String {
            
            TF_3.placeholder = name
        }else{
            TF_3.placeholder = "0.1"
            
        }
        
    }
    func setTF_4(){
        
        if let name = UserDefaults.standard.object(forKey: "TF_4") as? String {
            
            TF_4.placeholder = name
        }else{
            TF_4.placeholder = "0.005"
            
        }
        
    }
    func setTF_5(){
        
        if let name = UserDefaults.standard.object(forKey: "tf_5") as? String {
            
            tf_5.placeholder = name
        }else{
            tf_5.placeholder = "4"
            
        }
        
    }
    func setAdBanner(){
        let id = "ca-app-pub-7019441527375550/2358814075"
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
