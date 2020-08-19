//
//  TradeDetailViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit

class TradeDetailViewController:MGoogleADViewController{
    
    @IBOutlet weak var buy_price: UITextField!
    @IBOutlet weak var sell_price: UITextField!
    @IBOutlet weak var buy_num: UITextField!

    @IBOutlet weak var label_profit: UILabel!
    @IBOutlet weak var sell_num: UITextField!
    
    @IBOutlet weak var total_sell_price: UILabel!
    @IBOutlet weak var total_buy_price: UILabel!
    @IBOutlet weak var percentage_label: UILabel!

    @IBAction func button_calculation(_ sender: UIButton) {
 
        
        closeKeyboard()
        

        total()
        
        
    }

     var info = [ "沒折扣", "95折",
                 "9折","85折",
                 "8折", "79折","78折","77折","76折","75折","74折","73折","72折","71折",
                 "7折", "69折","68折","67折","66折","65折","64折","63折","62折","61折",
                 "6折", "59折","58折","57折","56折","55折","54折","53折","52折","51折",
                 "5折","49折","48折","47折","46折","45折","44折","43折","42折","41折",
                 "4折","39折","38折","37折","36折","35折","34折","33折","32折","31折",
                 "3折", "29折","28折","27折","26折","25折","24折","23折","22折","21折",
                 "2折","19折","18折","17折","16折","15折","14折","13折","12折","11折",
                 "1折","0.9折" ,"0.8折" ,"0.7折" ,"0.6折" ,"0.5折" ,"0.4折" ,"0.3折" ,"0.2折","0.1折" ,"免手續費"]
    var price = [1,0.95,
                 0.9,0.85,
                 0.8,0.79,0.78,0.77,0.76,0.75,0.74,0.73,0.72,0.71,
                 0.7,0.69,0.68,0.67,0.66,0.65,0.64,0.63,0.62,0.61,
                 0.6,0.59,0.58,0.57,0.56,0.55,0.54,0.53,0.52,0.51,
                 0.5,0.49,0.48,0.47,0.46,0.45,0.44,0.43,0.42,0.41,
                 0.4,0.39,0.38,0.37,0.36,0.35,0.34,0.33,0.32,0.31,
                 0.3,0.29,0.28,0.27,0.26,0.25,0.24,0.23,0.22,0.21,
                 0.2,0.19,0.18,0.17,0.16,0.15,0.14,0.13,0.12,0.11,
                 0.1,0.09,0.08,0.07,0.06,0.05,0.05,0.04,0.03,0.02,0.01,0]
    var pirceout = 1.0
    var total_buy = 0.0
    var total_sell = 0.0
    @IBOutlet weak var inputhandprice: UITextField!
    
    let handlingFee = 0.001425
    var tax = 0.003
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "現股獲利計算"
        setScreenName(screenName: "現股獲利計算", screenClassName: "TradeDetailViewController")
        buy_num.text = "1"
        sell_num.text = "1"
        setKeyKeyboardType()
        
        if(UserDefaults.standard.string(forKey: "handprice") != nil) {
          inputhandprice.placeholder = UserDefaults.standard.string(forKey: "handprice") as! String
          inputhandprice.text = UserDefaults.standard.string(forKey: "handprice") as! String
        }
        
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
              self.view.addGestureRecognizer(tap) // to Replace "TouchesBegan"
              
          }
          
          @objc func dismissKeyBoard() {
              self.view.endEditing(true)
          }
    func setKeyKeyboardType(){
        buy_price.keyboardType = UIKeyboardType.decimalPad
        sell_price.keyboardType = UIKeyboardType.decimalPad
        buy_num.keyboardType = UIKeyboardType.decimalPad
        sell_num.keyboardType = UIKeyboardType.decimalPad
        inputhandprice.keyboardType = UIKeyboardType.decimalPad

        
        
    }
    @IBAction func closeView(_ sender: Any) {
        setVibrate()

        dissmissView()

    }
    func closeKeyboard(){
        self.buy_price.resignFirstResponder()
        self.sell_price.resignFirstResponder()
        
        self.buy_num.resignFirstResponder()
        self.sell_num.resignFirstResponder()
        self.inputhandprice.resignFirstResponder()
    }
    func clearText(){
        buy_price.text = ""
        sell_price.text = ""
        buy_num.text = ""
        sell_num.text = ""
        inputhandprice.text = ""
    }
    func total(){
        setVibrate()

        var total = 0.0
        var total_buy = 0.0
        var total_sell = 0.0
        if(buy_price.text?.count==0||buy_num.text?.count==0||sell_price.text?.count==0||sell_num.text?.count==0 || inputhandprice.text?.count==0){
            setDilog()
            return
        }
        
        pirceout = Double(inputhandprice.text!)!
        UserDefaults.standard.set(inputhandprice.text!, forKey: "handprice")

        total_buy =   Double(buy_price.text!)! * Double(buy_num.text!)! * 1000
        total_sell =   Double(sell_price.text!)! * Double(sell_num.text!)! * 1000
        total_buy_price.textColor = UIColor.red
        total_sell_price.textColor = UIColor.green

        if((total_buy * handlingFee * pirceout)<=20){
            total_buy_price.text  = String(total_buy + 20)
            total_buy = (total_buy + 20)
            
        }else{
            total_buy_price.text  = String(total_buy + (total_buy * handlingFee * pirceout))
            total_buy = (total_buy + (total_buy * handlingFee * pirceout))
            
        }
        if( (total_sell * handlingFee * pirceout )<=20){
            total_sell_price.text = String(total_sell - 20 - ((total_sell * tax)))
            total_sell = (total_sell - 20 - ((total_sell * tax)))
            
        }else{
            total_sell_price.text = String(total_sell - (total_sell * handlingFee * pirceout)-(total_sell * tax))
            total_sell = (total_sell - (total_sell * handlingFee * pirceout)-(total_sell * tax))
        }
        
        total = total_sell - total_buy
        label_profit.textColor = UIColor.white
        label_profit.backgroundColor = UIColor.red
        label_profit.text = String(lround(total))
        percentage_label.textColor = UIColor.white
        percentage_label.backgroundColor = UIColor.red
        percentage_label.text = String(format: "%.2f",((total/total_buy) * 100 )) + "%"
        
    }
    
    
    func setDilog(){
        let controller = UIAlertController(title: "錯誤!", message: "忘了輸入數值", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    
    }
    

}
