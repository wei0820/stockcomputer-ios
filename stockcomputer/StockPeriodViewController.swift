//
//  StockPeriodViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/10/23.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
class StockPeriodViewController: MGoogleADViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var buy_price_edt: UITextField!
    
    @IBOutlet weak var buy_num_tf: UITextField!
    
    @IBOutlet weak var sell_price_tf: UITextField!
    
    @IBOutlet weak var sell_num_tf: UITextField!
    
    @IBOutlet weak var buypirce_label: UILabel!
    
    @IBOutlet weak var sellprice_label: UILabel!
    
    @IBOutlet weak var handPrice_label: UILabel!
    
    @IBOutlet weak var periodPrice_Label: UILabel!
    
    @IBOutlet weak var totallabel: UILabel!
    
    @IBOutlet var money_Label: UIView!
    
    let userDefault = UserDefaults()
    var handprice : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        buy_price_edt.delegate = self
        buy_num_tf.delegate = self
        sell_price_tf.delegate = self
        sell_num_tf.delegate = self
        buy_price_edt.keyboardType = .decimalPad
        buy_num_tf.keyboardType = .decimalPad
        sell_price_tf.keyboardType = .decimalPad
        sell_num_tf.keyboardType = .decimalPad
        sell_num_tf.delegate = self
        handPriceTextFeild.delegate = self
        handPriceTextFeild.keyboardType = .decimalPad
        if(( userDefault.value(forKey: "stockperiodhandprice")) != nil){
            handprice =  userDefault.value(forKey: "stockperiodhandprice") as! String
            handPriceTextFeild.text = handprice

        }else{
            handprice =  "50"
            userDefault.set(handprice, forKey: "stockperiodhandprice")
            handPriceTextFeild.text = handprice

        }
       

        
    }
    
    @IBOutlet weak var handPriceTextFeild: UITextField!
    
  
    
    @IBAction func search_button(_ sender: Any) {
        let url:URL?=URL.init(string: "https://www.pfcf.com.tw/eventweb/top10/")
             UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
    }
    
    
    @IBAction func closeView(_ sender: Any) {
        dissmissView()
    }
    
    @IBAction func cal_view(_ sender: Any) {
        if(buy_num_tf.text!.isEmpty || buy_price_edt.text!.isEmpty || sell_price_tf.text!.isEmpty || sell_num_tf.text!.isEmpty ){
            setToast(s: "請檢查是否少輸入數值")
        }else{
            userDefault.set(handPriceTextFeild.text!, forKey: "stockperiodhandprice")
            var buyprice : Double = Double(buy_price_edt.text!)! * Double(buy_num_tf.text!)! * 2000
            var sellprice : Double = Double(sell_price_tf.text!)! * Double(sell_num_tf.text!)! * 2000
            var buyAndSellPrice = (buyprice * 0.00002 ) + (sellprice * 0.00002)
            var allhandprice = Double(handPriceTextFeild.text!)! * 2
            var total = sellprice - buyprice - buyAndSellPrice  - allhandprice
            
            buypirce_label.text = String(lround(buyprice))
            sellprice_label.text = String(lround(sellprice))
            totallabel.text = String(lround(total))
            periodPrice_Label.text  = String(lround(buyAndSellPrice))
 

        }
        
    }
    
    // 按空白處會隱藏編輯狀態
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
