//
//  MarginController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MarginController: UIViewController  ,GADBannerViewDelegate , UIPickerViewDelegate, UIPickerViewDataSource {
    var adBannerView: GADBannerView?
    let fullScreenSize = UIScreen.main.bounds.size
    let meals = ["早餐","午餐","晚餐","宵夜"]
    var formatter: DateFormatter! = nil
    @IBOutlet weak var date: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdBanner()
        var myTextField = UITextField(frame: CGRect(x: 0, y: 0, width: fullScreenSize.width, height: 40))
//
//        // 建立 UIPickerView
//        let myPickerView = UIPickerView()
//
//        // 設定 UIPickerView 的 delegate 及 dataSource
//        myPickerView.delegate = self as! UIPickerViewDelegate
//        myPickerView.dataSource = self as! UIPickerViewDataSource
//
//        // 將 UITextField 原先鍵盤的視圖更換成 UIPickerView
//        myTextField.inputView = myPickerView
//
//        // 設置 UITextField 預設的內容
//        myTextField.text = meals[0]
//
//        // 設置 UITextField 的 tag 以利後續使用
//        myTextField.tag = 100
//
//        // 設置 UITextField 其他資訊並放入畫面中
//        myTextField.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
//        myTextField.textAlignment = .center
//        myTextField.center = CGPoint(x: fullScreenSize.width * 0.5, y: fullScreenSize.height * 0.15)
//        self.view.addSubview(myTextField)
//
        
//        // 建立另一個 UITextField
//        myTextField = UITextField(frame: CGRect(x: 0, y: 0, width: fullScreenSize.width, height: 40))
        
        // 初始化 formatter 並設置日期顯示的格式
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"
        
        // 建立一個 UIDatePicker
        let myDatePicker = UIDatePicker()
        
        // 設置 UIDatePicker 格式
        myDatePicker.datePickerMode = .date
        
        // 設置 UIDatePicker 顯示的語言環境
        myDatePicker.locale = Locale(identifier: "zh_TW")
        
        // 設置 UIDatePicker 預設日期為現在日期
        myDatePicker.date = Date()
        
        // 設置 UIDatePicker 改變日期時會執行動作的方法
        myDatePicker.addTarget(self, action: #selector(MarginController.datePickerChanged), for: .valueChanged)
        
        // 將 UITextField 原先鍵盤的視圖更換成 UIDatePicker
        date.inputView = myDatePicker
        
        // 設置 UITextField 預設的內容
        date.text = formatter.string(from: myDatePicker.date)
        
        // 設置 UITextField 的 tag 以利後續使用
        date.tag = 200
        
//        // 設置 UITextField 其他資訊並放入畫面中
//        date.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
//        date.textAlignment = .center
//        date.center = CGPoint(x: fullScreenSize.width * 0.5, y: fullScreenSize.height * 0.75)
        self.view.addSubview(date)
        
        
        // 增加一個觸控事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(MarginController.hideKeyboard(tapG:)))
        
        tap.cancelsTouchesInView = false
        
        // 加在最基底的 self.view 上
        self.view.addGestureRecognizer(tap)
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
    
    
    // UIPickerViewDataSource 必須實作的方法：UIPickerView 有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewDataSource 必須實作的方法：UIPickerView 各列有多少行資料
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        // 返回陣列 meals 的成員數量
        return meals.count
    }
    
    // UIPickerView 每個選項顯示的資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 設置為陣列 meals 的第 row 項資料
        return meals[row]
    }
    
//    // UIPickerView 改變選擇後執行的動作
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        // 依據元件的 tag 取得 UITextField
//        let myTextField = self.view?.viewWithTag(100) as? UITextField
//
//        // 將 UITextField 的值更新為陣列 meals 的第 row 項資料
//        myTextField?.text = meals[row]
//    }
    
    // UIDatePicker 改變選擇時執行的動作
    @objc func datePickerChanged(datePicker:UIDatePicker) {
        // 依據元件的 tag 取得 UITextField
        let myTextField = self.view?.viewWithTag(200) as? UITextField
        
        // 將 UITextField 的值更新為新的日期
        myTextField?.text = formatter.string(from: datePicker.date)
        print( formatter.string(from: datePicker.date))
    }
    
    // 按空白處會隱藏編輯狀態
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
}
