//
//  WarrantViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/8/7.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class WarrantViewController: MGoogleADViewController,UITextFieldDelegate {
    @IBOutlet weak var buypriceTF: UITextField!
    
    @IBOutlet weak var SellpricveTF: UITextField!
    
    @IBOutlet weak var buyNumTf: UITextField!
    
    @IBOutlet weak var sellNumTF: UITextField!
    
    @IBOutlet weak var Label_1: UILabel!
    
    @IBOutlet weak var label_2: UILabel!
    
    @IBOutlet weak var label_3: UILabel!
    
    @IBOutlet weak var Label_4: UILabel!
    
    @IBOutlet weak var label_5: UILabel!
    
    @IBAction func cal(_ sender: Any) {
        if(buypriceTF.text?.count == 0 || SellpricveTF.text?.count == 0 || buyNumTf.text?.count == 0 || sellNumTF.text?.count == 0 || inputHandPrice.text?.count == 0){
            setToast(s: "請檢查是否哪邊尚未輸入!!")
            
        }else{
            var buuyhandprice :Double =  Double(buypriceTF.text!)! *  Double(buyNumTf.text!)! * 1000 * 0.001425 *  Double(inputHandPrice.text!)!
             var sellhandprice :Double =  Double(SellpricveTF.text!)! *  Double(sellNumTF.text!)! * 1000 * 0.001425 *  Double(inputHandPrice.text!)!
            if (buuyhandprice <= 20)  { buuyhandprice = 20.0 }
            if (sellhandprice <= 20)  { sellhandprice = 20.0 }
            label_3.text = String(buuyhandprice + sellhandprice)
            
            var buyproce :Double =  Double(buypriceTF.text!)! *  Double(buyNumTf.text!)! * 1000 + buuyhandprice
        
            
            

               
            
            
            
        }
    }
    func setView(){
        buypriceTF.keyboardType = .decimalPad
        SellpricveTF.keyboardType = .decimalPad
        buyNumTf.keyboardType = .numberPad
        sellNumTF.keyboardType = .numberPad
        buypriceTF.delegate = self
        SellpricveTF.delegate = self
        buyNumTf.delegate = self
        sellNumTF.delegate = self

        

        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        buyNumTf.text = "1"
        sellNumTF.text = "1"
        setView()
        
        if(UserDefaults.standard.string(forKey: "handprice") != nil){
            inputHandPrice.placeholder = UserDefaults.standard.string(forKey: "handprice") as! String
            inputHandPrice.text = UserDefaults.standard.string(forKey: "handprice") as! String
        }
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var inputHandPrice: UITextField!
    

    @IBAction func close(_ sender: Any) {
        setVibrate()
        dissmissView()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //_ textField
    // 開始進入編輯狀態
        func textFieldDidBeginEditing(_ textField: UITextField){
        }
     
        // 可能進入結束編輯狀態
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
     
            return true
        }
     
        // 結束編輯狀態(意指完成輸入或離開焦點)
        func textFieldDidEndEditing(_ textField: UITextField) {
     
                    }
     
        // 按下Return後會反應的事件
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //利用此方式讓按下Return後會Toogle 鍵盤讓它消失
            textField.resignFirstResponder()
            return false
        }
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
     }
}
