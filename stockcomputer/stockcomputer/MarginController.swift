//
//  MarginController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Kanna
import Alamofire
import Toaster
import JGProgressHUD

class MarginController: MGoogleADViewController{
    let fullScreenSize = UIScreen.main.bounds.size
    var formatter: DateFormatter! = nil
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var label_3: UILabel!
    @IBOutlet weak var label_4: UILabel!
    
    @IBOutlet weak var label_6: UILabel!
    @IBOutlet weak var label_5: UILabel!
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
            /**
             券賣：
             >>9成本金(235 *1000 * 90%)=交割保證金(211,500元)
             >>本金(235 *1000*1)-手續費(235 *1000*1*1.425‰)-證交稅(235 *1000*1*3‰)-借券費(235 *1000*1*0.8‰)=擔保品(233,772元)
             券買：
             >>[保證金(211,500)+擔保品(233,772)]*0.1%融券利率*24天/365=利息(29元)
             >>本金(222.5 *1000) +手續費(222.5 * 1000 * 1張 *1.425 ‰)=回補價金(222,817元)
             >>擔保品(233,772)-回補價金(222,817)+保證金(211,500)+利息(29)=應收金額(222,484元)
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
            var  guaranteePrice : Int =  Int(Double(sellPriceInt) - handPrice - changePrice - borrowPrice)
            //融券的保證金
            var  guaranteeMoney : Int  = Int(Double(sellPriceInt)  * 0.9)
            //利息
            var  interestPrice  = Int((Double(guaranteePrice + guaranteeMoney) * Double(dayInt) * 0.002) / 365)
            var returnMoney : Int = buyPriceInt + Int(handPrice)
            var shouldPayMoney : Int =  Int(guaranteePrice) - returnMoney + Int(interestPrice) + Int(guaranteeMoney)
            var getMoney = shouldPayMoney - guaranteeMoney
            
            
            label_1.text = "交割保證金:" + String(guaranteeMoney)
            label_2.text = "擔保品:" + String(guaranteePrice)
            label_3.text = "利息:" + String(interestPrice)
            label_4.text = "回補價金:" + String(returnMoney)
            label_5.text = "應收金額:" + String(shouldPayMoney)
            if(getMoney>0){
                label_6.textColor = UIColor.red
                
            }else{
                label_6.textColor = UIColor.green

            }
            label_6.text = "預估收益:" + String(getMoney)
            
        }else{
            
            setToast(s: "請勿輸入空值")
            
        }
        

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "融券獲利計算"
        sellNum.text = "1000"
        buyNum.text = "1000"
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
