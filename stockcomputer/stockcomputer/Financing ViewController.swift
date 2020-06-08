//
//  Financing ViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/5/20.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class Financing_ViewController: MGoogleADViewController {
    let fullScreenSize = UIScreen.main.bounds.size
       var formatter: DateFormatter! = nil
    var startDateStr :Date? = nil
       var EndDateStr :Date? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        sellNum.text = "1000"
        buyNum.text = "1000"
        setDatePickerView()
        setUITextField()

        // Do any additional setup after loading the view.
    }
    @IBAction func cal(_ sender: Any) {
        
        if(buyMoney.text!.isEmpty && sellMoney.text!.isEmpty && loanMOney.text!.isEmpty){
            setToast(s: "請輸入數值")
            
        }else{
            var  dayInt: Int  =  DateManager.distancesFrom(startDateStr!, to: EndDateStr!)

            var buyMoneyDoube :Double = Double(buyMoney.text!)!
            var sellMoneyDouble : Double = Double(sellMoney.text!)!
            var sellNumInt : Int =  Int(sellNum.text!)!
            var buyNumInt  : Int =  Int(buyNum.text!)!
            var loandMoneyDoule : Double =  0.1 * Double(loanMOney.text!)!
            // 買入 應付金額
            // 融資金
            var loanMoneyInt :Double = buyMoneyDoube * Double(sellNumInt) * loandMoneyDoule
            var handPrice : Double = buyMoneyDoube * Double(buyNumInt) * 0.001425
            var buyMoneyInt :Int = Int( buyMoneyDoube * Double(buyNumInt))  - Int(loanMoneyInt) + Int(handPrice)
            print("Jack",buyMoneyInt)
            // 賣出
            var sellMoneyD :Double = sellMoneyDouble * Double(sellNumInt)
            var sellHandPrice : Double = sellMoneyD * 0.001425
            var changePrice : Double =   Double(sellMoneyD) * 0.003
            var interest : Double = (loanMoneyInt * 0.0645 * (Double(dayInt)/365))
            var allMoney : Double = sellMoneyD - sellHandPrice - interest  - loanMoneyInt
            var money  :Int = Int(allMoney) - buyMoneyInt
            
            label_1.text = "融資金:" + String(Int(loanMoneyInt))
            label_2.text = "應付金額:" + String(buyMoneyInt)
            label_3.text = "賣出金額:" + String(Int(sellMoneyD))
            label_6.text = "交易稅:" +   String(Int(changePrice))
            label_4.text = "利息:" + String(Int(interest)) + "(共" + String(dayInt) + "天)"
            label_5.text = "損益:" + String(money)
         

            

//
            
        }
        
        
        
        
        
    }
    
    
    func setUITextField(){
         buyNum.keyboardType = .decimalPad
         sellNum.keyboardType = .decimalPad
         buyMoney.keyboardType = .decimalPad
         sellMoney.keyboardType = .decimalPad
        loanMOney.keyboardType = .decimalPad
         buyNum.resignFirstResponder()
         sellNum.resignFirstResponder()
         buyMoney.resignFirstResponder()
         sellMoney.resignFirstResponder()
        loanMOney.resignFirstResponder()
        loanMOney.placeholder = "輸入成數(ex:6成 輸入 6)"
         
     }
    @IBOutlet weak var sellMoney: UITextField!
    @IBOutlet weak var buyMoney: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var loanMOney: UITextField!
    
    @IBOutlet weak var sellNum: UITextField!
    @IBOutlet weak var buyNum: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var label_1: UILabel!

    @IBOutlet weak var label_2: UILabel!
    
    @IBOutlet weak var label_3: UILabel!
    
    @IBOutlet weak var label_6: UILabel!
    
    @IBOutlet weak var label_4: UILabel!
    
    @IBOutlet weak var label_5: UILabel!
    
    @IBAction func closeview(_ sender: Any) {
        dissmissView()
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
           startTime.inputView = myDatePicker
           endTime.inputView = myDatePicker2
           
           // 設置 UITextField 預設的內容
           startTime.text = formatter.string(from: myDatePicker.date)
           endTime.text = formatter.string(from: myDatePicker2.date)
           startDateStr =  myDatePicker.date
           EndDateStr = myDatePicker2.date
           
           // 設置 UITextField 的 tag 以利後續使用
           startTime.tag = 200
           self.view.addSubview(startTime)
           endTime.tag = 300
           self.view.addSubview(endTime)
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
