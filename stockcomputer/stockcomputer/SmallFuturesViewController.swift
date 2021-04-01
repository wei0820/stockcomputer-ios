//
//  SmallFuturesViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2021/3/2.
//  Copyright © 2021 jackpan. All rights reserved.
//

import UIKit

class SmallFuturesViewController: MGoogleADViewController ,UITextFieldDelegate{
    @IBOutlet weak var buypriceLabel: UILabel!
    @IBOutlet weak var selPriceLabel: UILabel!
    @IBOutlet weak var handPrcie: UILabel!
    @IBOutlet weak var buysellPrice: UILabel!
    @IBOutlet weak var TotalPrice: UILabel!
    @IBOutlet weak var sellnumTF: UITextField!
    @IBOutlet weak var buynumTF: UITextField!
    @IBOutlet weak var buyTF: UITextField!
    @IBOutlet weak var sellTF: UITextField!
    
    @IBOutlet weak var handPrice_TF: UITextField!
    var myHandPriceDefaults :UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myHandPriceDefaults = UserDefaults.standard
        initTextField()
        
        if let handprice_small = myHandPriceDefaults.object(forKey: "handprice_small") as? String {
            handPrice_TF.text = handprice_small
        } else {
            
            handPrice_TF.placeholder = "請輸入手續費"
        }
        
        
        
        
    }
    func initTextField(){
        handPrice_TF.borderStyle = .roundedRect
        handPrice_TF.clearButtonMode = .whileEditing
        handPrice_TF.keyboardType = .decimalPad
        handPrice_TF.returnKeyType = .done
        handPrice_TF.delegate = self
        
        
        buyTF.borderStyle = .roundedRect
        buyTF.clearButtonMode = .whileEditing
        buyTF.keyboardType = .decimalPad
        buyTF.returnKeyType = .done
        buyTF.delegate = self
        sellTF.borderStyle = .roundedRect
        sellTF.clearButtonMode = .whileEditing
        sellTF.keyboardType = .decimalPad
        sellTF.returnKeyType = .done
        sellTF.delegate = self
        
        sellnumTF.borderStyle = .roundedRect
        sellnumTF.clearButtonMode = .whileEditing
        sellnumTF.keyboardType = .decimalPad
        sellnumTF.returnKeyType = .done
        sellnumTF.delegate = self
        
        buynumTF.borderStyle = .roundedRect
        buynumTF.clearButtonMode = .whileEditing
        buynumTF.keyboardType = .decimalPad
        buynumTF.returnKeyType = .done
        buynumTF.delegate = self
        
        
        
        
        
    }
    
    @IBAction func closeView(_ sender: Any) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
    }
    
    @IBAction func cla_btn(_ sender: Any) {
        
        if(buyTF.text!.isEmpty || sellTF.text!.isEmpty || sellnumTF.text!.isEmpty || sellnumTF.text!.isEmpty  || handPrice_TF.text!.isEmpty){
            setToast(s: "請檢查是否少輸入數值！")
            
        }else{
            var buy : Double =  Double(buyTF.text!) as! Double
            var buyNum : Int  = Int(buynumTF.text!) as! Int
            var sell : Double =  Double(sellTF.text!) as! Double
            var sellNum : Int  = Int(sellnumTF.text!) as! Int
            var handPrice : Int = Int( handPrice_TF.text!) as! Int
            myHandPriceDefaults.set(
                handPrice_TF.text, forKey: "handprice_small")
            myHandPriceDefaults.synchronize()
            
            var buyAndSellPrice  = lround((0.00002 * (100 * buy * Double(buyNum))) +  (0.00002 * (100 * sell * Double(sellNum))))
            buysellPrice.text = String(buyAndSellPrice)
            
            
        }
        
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let url:URL?=URL.init(string: "https://www.taifex.com.tw/cht/5/stockMargining")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    
    
    @IBAction func searchMoney(_ sender: Any) {
        let alertController = UIAlertController(title: "保證金查詢",
                                                message: "請先用左上角查詢原始保證金適用比例", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "股票價格"
            textField.keyboardType = .decimalPad
        }
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            
            textField.placeholder = "原始保證金適用比例"
            textField.keyboardType = .decimalPad

        }
        
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "維持保證金適用比例"
            textField.keyboardType = .decimalPad

        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let stockPrice = alertController.textFields!.first!
            let original = alertController.textFields![1] as UITextField
            let maintain = alertController.textFields![2] as UITextField

     
            
            if(stockPrice.text!.isEmpty || original.text!.isEmpty || maintain.text!.isEmpty){
                
            }else{
                var stockPriceDouble : Double = Double(stockPrice.text!) as! Double
                var originalDouble : Double =  Double(original.text!) as! Double
                var maintainDouble : Double  = Double(maintain.text!) as! Double
                
                
                
                var orinigalPrice : Int = lround(originalDouble * 0.01 * stockPriceDouble * 100)
                var maintainPrice : Int = lround(maintainDouble * 0.01 * stockPriceDouble * 100)
                
                
                var title : String = "期貨保證金:" + String(orinigalPrice) + "\n" + "維持保證金:" + String(maintainPrice)
                
                
                
                
                
                
                
            let alert = UIAlertController(title: "提示", message: title, preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
            self.present(alert, animated: true, completion: nil)
                
            }
            
            
            
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
        
        
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
