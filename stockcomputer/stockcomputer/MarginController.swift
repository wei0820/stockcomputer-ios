//
//  MarginController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MarginController: MGoogleADViewController{
    let fullScreenSize = UIScreen.main.bounds.size
    var formatter: DateFormatter! = nil
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var label_1: UILabel!
    
    @IBOutlet weak var percentageTextField: UITextField!
    @IBOutlet weak var buyNum: UITextField!
    @IBOutlet weak var sellNum: UITextField!
    @IBOutlet weak var buyPrice: UITextField!
    @IBOutlet weak var sellPrice: UITextField!
    @IBOutlet weak var EndDate: UITextField!
    var startDateStr :Date? = nil
    var EndDateStr :Date? = nil
    @IBAction func cal_btn(_ sender: Any) {
        if(!buyNum.text!.isEmpty && !sellNum.text!.isEmpty && !buyPrice.text!.isEmpty && !sellPrice.text!.isEmpty){
            
            var sellPirceInt :Int = Int(sellPrice.text!)!
            var buyPricepInt : Int = Int(buyPrice.text!)!
            var sellNumInt : Int =  Int(sellNum.text!)!
            var buyNumInt  : Int =  Int(buyNum.text!)!
            var percentageInt : Int = Int(percentageTextField.text!)!
            var percentageDouble : Double = Double(percentageInt)  * 0.01
            /**
             作空回補
              範例：當日融券賣出10元10張，10天後融券買回12元10張，其應收付金額計算？
              1) (星期一) 券賣10元10張， ((券賣留倉，僅須先付9成保證金)
             應付金額：10元 *10,000股=100,000元 * 9成= 90,000元
              2) (隔週星期三) 券買12元10張，應收金額：
             手續費、交易稅、借券費(萬分之8 - 參考)及融券利息(年利率0.4% - 參考)等券回補時才會扣除。
             融券的擔保品：10元 *10,000股=100,000元
             手續費：100,000元 * 0.1425%=142元
             交易稅：100,000元 * 0.3%=300元
             借券費：100,000元 * 0.08%=80元
             融券擔保品：100,000-142-300-80=99,478元
             融券的保證金：10 * 10,000股=100,000元 * 9成=90,000元
             利息：﹝99,478 * 0.4% * (9/365)﹞ + ﹝90,000 * 0.4%X(9/365)﹞=9.8+8.8=18元
             回補價金：12元 * 10,000股=120,000元 + 171元 (120,000*0.1425%)=120,171元
             應收金額：99,478元 - 120,171元 + 90,000元 + 18元=69,325元
             */
            // 付出的成本
            var  dayInt: Int  =  DateManager.distancesFrom(startDateStr!, to: EndDateStr!)
            var sellPriceInt = sellNumInt * sellPirceInt
            var buyPriceInt = buyNumInt * buyPricepInt
            // 手續費
            var handPrice : Double = Double(sellPriceInt) * 0.001425
            // 交易稅
            var changePrice : Double =   Double(sellPriceInt) * 0.003
            var borrowPrice  : Double  = Double(sellPriceInt) * 0.0008
            //融券擔保品
            var  guaranteePrice : Double =  Double(sellPriceInt) - handPrice - changePrice - borrowPrice
            //融券的保證金
            var  guaranteeMoney : Double  = Double(sellPriceInt)  * percentageDouble
            //利息
            var  interestPrice  : Double =  ((guaranteePrice * 0.004) * Double((dayInt / 365 ))) + ((guaranteeMoney  * 0.004) * Double((dayInt / 365 )))
            print(dayInt)
            print(sellPriceInt)
            print(buyPriceInt)
            print(handPrice)
            print(changePrice)
            print(borrowPrice)
            print(guaranteePrice)
            print(guaranteeMoney)
            print(interestPrice)
            /*150000
            145000
            213.75
            450.0
            120.0
            149216.25
            13500.0
            0.0*/

            label_1.text = "利息:" + String(interestPrice)
            
            
            
            
            
                
            
            
            
            
            
            
            
        }else{
            
            setToast(s: "請勿輸入空值")
            
        }
        

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "融券獲利計算"
        // 初始化 formatter 並設置日期顯示的格式
        setDatePickerView()
        setUITextField()
        
        
    }
    func setUITextField(){
        buyNum.keyboardType = .decimalPad
        sellNum.keyboardType = .decimalPad
        buyPrice.keyboardType = .decimalPad
        sellPrice.keyboardType = .decimalPad
        buyNum.resignFirstResponder()
        sellNum.resignFirstResponder()
        buyPrice.resignFirstResponder()
        sellPrice.resignFirstResponder()
        
    }
    
    func setDatePickerView(){
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        // 建立一個 UIDatePicker
        let myDatePicker = UIDatePicker()
        let myDatePicker2 = UIDatePicker()
        
        
        // 設置 UIDatePicker 格式
        myDatePicker.datePickerMode = .date
        myDatePicker2.datePickerMode = .date
        
        
        // 設置 UIDatePicker 顯示的語言環境
        myDatePicker.locale = Locale(identifier: "zh_TW")
        myDatePicker2.locale = Locale(identifier: "zh_TW")
        
        
        // 設置 UIDatePicker 預設日期為現在日期
        myDatePicker.date = Date()
        myDatePicker2.date = Date()
        
        
        // 設置 UIDatePicker 改變日期時會執行動作的方法
        myDatePicker.addTarget(self, action: #selector(MarginController.datePickerChanged), for: .valueChanged)
        
        myDatePicker2.addTarget(self, action: #selector(MarginController.datePickerChanged), for: .valueChanged)
        
        
        myDatePicker.tag = 1
        myDatePicker2.tag = 2
        // 將 UITextField 原先鍵盤的視圖更換成 UIDatePicker
        date.inputView = myDatePicker
        EndDate.inputView = myDatePicker2
        
        // 設置 UITextField 預設的內容
        date.text = formatter.string(from: myDatePicker.date)
        EndDate.text = formatter.string(from: myDatePicker2.date)
        startDateStr =  myDatePicker.date
        EndDateStr = myDatePicker2.date
        
        // 設置 UITextField 的 tag 以利後續使用
        date.tag = 200
        self.view.addSubview(date)
        EndDate.tag = 300
        self.view.addSubview(EndDate)
        // 增加一個觸控事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(MarginController.hideKeyboard(tapG:)))
        tap.cancelsTouchesInView = false
        // 加在最基底的 self.view 上
        self.view.addGestureRecognizer(tap)
        
        
    }
    
    
    
    // UIPickerViewDataSource 必須實作的方法：UIPickerView 有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // UIDatePicker 改變選擇時執行的動作
    @objc func datePickerChanged(datePicker:UIDatePicker) {
        // 依據元件的 tag 取得 UITextFiel
        let myTextField = self.view?.viewWithTag(200) as? UITextField
        let myTextField2 = self.view?.viewWithTag(300) as? UITextField
        
        if(datePicker.tag == 1){
            myTextField?.text = formatter.string(from: datePicker.date)
            startDateStr =  datePicker.date
            
        }else{
            myTextField2?.text = formatter.string(from: datePicker.date)
            EndDateStr = datePicker.date
            
            
        }
    }
    
    // 按空白處會隱藏編輯狀態
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
}
