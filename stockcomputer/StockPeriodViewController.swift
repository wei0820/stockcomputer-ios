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
    
    
    @IBOutlet var money_Label: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buy_price_edt.delegate = self
        buy_num_tf.delegate = self
        sell_price_tf.delegate = self
        sell_num_tf.delegate = self
        buy_price_edt.keyboardType = .decimalPad
        buy_num_tf.keyboardType = .decimalPad
        sell_price_tf.keyboardType = .decimalPad
        sell_num_tf.delegate = self
        
        handPriceTextFeild.delegate = self
        handPriceTextFeild.keyboardType = .decimalPad


        
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
