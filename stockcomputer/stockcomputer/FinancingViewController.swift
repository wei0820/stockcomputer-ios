//
//  FinancingViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FinancingViewController: MUIViewController  ,GADBannerViewDelegate ,UITextFieldDelegate{
    var adBannerView: GADBannerView?
    var formatter: DateFormatter! = nil
    let datePicker = UIDatePicker()
    var start : Date!
    var end : Date!
    
    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var mInterestRate: UITextField!
    @IBOutlet weak var mStatr: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setAdBanner()
        setKeyKeyboardType()
        if let name = UserDefaults.standard.object(forKey: "interestRate") as? String {
            
            mInterestRate.placeholder = name
            mInterestRate.text = ""
        }
        showDatePicker(v: mStatr,tag: 0)
        showDatePicker(v: mEndDate,tag: 1)
     
    }
    @IBOutlet weak var mEndDate: UITextField!

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mInterestRate.resignFirstResponder()
        mInterestRate.resignFirstResponder()  //if desired
        UserDefaults.standard.set(mInterestRate.text, forKey:"interestRate")
        
        
        return true
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
    
    func setKeyKeyboardType(){
        mInterestRate.keyboardType = UIKeyboardType.numbersAndPunctuation
        mInterestRate.returnKeyType = .done
    }
    
    func closeKeyboard(){
        self.mInterestRate.resignFirstResponder()
    
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
 

    func showDatePicker(v :UITextField,tag :Int){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "zh_TW")

        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        if(tag==0){
             let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneStartdatePicker));
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            
            toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            
            v.inputAccessoryView = toolbar
            v.inputView = datePicker
        }else{
             let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEnddatePicker));
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            
            toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            
            v.inputAccessoryView = toolbar
            v.inputView = datePicker
        }
       
        
    }
    @objc func doneStartdatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"
        mStatr.text = formatter.string(from: datePicker.date )
        start = datePicker.date
        self.view.endEditing(true)
    }
    @objc func doneEnddatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"
        mEndDate.text = formatter.string(from: datePicker.date )
        end =  datePicker.date
        self.view.endEditing(true)
        
        print(dateDifference(end,  from: start))
        day.text = String(dateDifference(end,  from: start)) + "天"
        day.textColor = UIColor.black

    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
  
    //MARK: 計算天數差
     func dateDifference(_ dateA:Date, from dateB:Date) -> Int {
        let interval = dateA.timeIntervalSince(dateB)
     
        return lround(interval/86400)
        
    }
}
