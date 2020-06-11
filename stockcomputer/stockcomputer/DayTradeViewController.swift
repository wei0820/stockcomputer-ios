//
//  DayTradeViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit

class DayTradeViewController: MGoogleADViewController  ,UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var title_label: UILabel!
    
    @IBOutlet weak var message_labe: UILabel!
    @IBOutlet weak var buy_price: UITextField!
    @IBOutlet weak var sell_price: UITextField!
    @IBOutlet weak var buy_num: UITextField!
    
    @IBOutlet weak var label_profit: UILabel!
    @IBOutlet weak var sell_num: UITextField!
    
    @IBOutlet weak var sell_buy: UITextField!
    
    @IBOutlet weak var total_sell_price: UILabel!
    @IBOutlet weak var total_buy_price: UILabel!
    @IBAction func button_calculation(_ sender: UIButton) {
        
        
        closeKeyboard()
        
        total()
        
        
    }
    @IBOutlet weak var percentage_label: UILabel!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return info.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return info[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedValue = pickerView.selectedRow(inComponent: 0)
        pirceout = price[selectedValue]
    }
    var info = [ "沒折扣", "95折",
                 "9折","85折",
                 "8折", "75折",
                 "7折", "65折",
                 "6折", "55折",
                 "5折","45折",
                 "4折","35折",
                 "3折", "28折",
                 "2折","19折","18折","17折","16折","15折","14折","13折","12折","11折",
                 "1折","0.9折" ,"0.8折" ,"0.7折" ,"0.6折" ,"0.5折" ,"0.4折" ,"0.3折" ,"0.2折","0.1折" ,"免手續費"]
    var price = [1,0.95,
                 0.9,0.85,
                 0.8,0.75,
                 0.7,0.65,
                 0.6,0.55,
                 0.5,0.45,
                 0.4,0.35,
                 0.3,0.28,0.25,
                 0.2,0.19,0.18,0.17,0.16,0.15,0.14,0.13,0.12,0.11,
                 0.1,0.09,0.08,0.07,0.06,0.05,0.05,0.04,0.03,0.02,0.01,0]
    
    var pirceout = 1.0
    var total_buy = 0.0
    var total_sell = 0.0
    
    let handlingFee = 0.001425
    var tax = 0.0015
    var type = ""
    var formatter: DateFormatter! = nil
    
    @IBAction func close(_ sender: Any) {
        dissmissView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "現股當沖獲利計算"
        setScreenName(screenName: "現股當沖獲利計算", screenClassName: "DayTradeViewController")
        buy_num.text = "1000"
        sell_num.text = "1000"
        setKeyKeyboardType()
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
        
        
    }
    func closeKeyboard(){
        self.buy_price.resignFirstResponder()
        self.sell_price.resignFirstResponder()
        
        self.buy_num.resignFirstResponder()
        self.sell_num.resignFirstResponder()
    }
    func clearText(){
        buy_price.text = ""
        sell_price.text = ""
        buy_num.text = ""
        sell_num.text = ""
    }
    func total(){
        var total = 0.0
        var total_buy = 0.0
        var total_sell = 0.0
        if(buy_price.text?.count==0||buy_num.text?.count==0||sell_price.text?.count==0||sell_num.text?.count==0){
            setDilog()
            return
        }
        
        
        total_buy =   Double(buy_price.text!)! * Double(buy_num.text!)!
        total_sell =   Double(sell_price.text!)! * Double(sell_num.text!)!
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
        label_profit.text = String(total)
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
