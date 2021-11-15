//
//  DayTradeViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/2/2.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit

class DayTradeViewController: MGoogleADViewController{
    
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

    var pirceout = 1.0
    var total_buy = 0.0
    var total_sell = 0.0
    
    let handlingFee = 0.001425
    var tax = 0.0015
    var type = ""
    var formatter: DateFormatter! = nil
    
    
    @IBOutlet weak var inputhandprice: UITextField!
    
    @IBAction func close(_ sender: Any) {
        setVibrate()
        dissmissView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "現股當沖獲利計算"
        if(UserDefaults.standard.string(forKey: "handprice") != nil) {
            inputhandprice.placeholder = UserDefaults.standard.string(forKey: "handprice") as! String
            inputhandprice.text = UserDefaults.standard.string(forKey: "handprice") as! String
        }
        setScreenName(screenName: "現股當沖獲利計算", screenClassName: "DayTradeViewController")
        buy_num.text = "1"
        sell_num.text = "1"
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
        inputhandprice.keyboardType = .decimalPad
        
        
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
        if(buy_price.text?.count==0||buy_num.text?.count==0||sell_price.text?.count==0||sell_num.text?.count==0 || inputhandprice.text?.count == 0){
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
        var subtitle :String = ""

        if(lround(total) <= -1){
            subtitle = "是虧損的！！"
        }else{
            subtitle = "是賺錢的！！"
        }
        
        NotificationManager.CreateNotification(title: "今日做當沖", subtitle: subtitle, body: "獲利：" + String(lround(total)) + "\n" +  "獲利率:" + String(format: "%.2f",((total/total_buy) * 100 )) + "%")
    }
    
    func setDilog(){
        let controller = UIAlertController(title: "錯誤!", message: "忘了輸入數值", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
        
    }
   
    
}
