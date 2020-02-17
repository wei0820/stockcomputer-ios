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
    
    @IBOutlet weak var buyNum: UITextField!
    @IBOutlet weak var sellNum: UITextField!
    @IBOutlet weak var buyPrice: UITextField!
    @IBOutlet weak var sellPrice: UITextField!
    @IBOutlet weak var EndDate: UITextField!
    
    @IBAction func cal_btn(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "融券獲利計算"
        // 初始化 formatter 並設置日期顯示的格式
        
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"
        
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
        var startDate :String = ""
        var EndDate :String = ""
        if(datePicker.tag == 1){
            myTextField?.text = formatter.string(from: datePicker.date)
            startDate = formatter.string(from: datePicker.date)

        }else{
            myTextField2?.text = formatter.string(from: datePicker.date)
            EndDate = formatter.string(from: datePicker.date)


        }
        print("date",startDate)
        print("date",EndDate)


        
        // 將 UITextField 的值更新為新的日期
//        myTextField2?.text = formatter.string(from: datePicker.date)


    }
    
    // 按空白處會隱藏編輯狀態
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
}
