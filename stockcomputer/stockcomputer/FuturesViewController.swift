//
//  FuturesViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/11/27.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
class FuturesViewController: MGoogleADViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var buyprice: UITextField!
    @IBOutlet weak var sellprice: UITextField!
    @IBOutlet weak var buynum: UITextField!
    @IBOutlet weak var sellnum: UITextField!
    @IBOutlet weak var mSwurch: UISwitch!
    @IBOutlet weak var maintain: UILabel!
    
    @IBOutlet var mProfit: UIView!
    @IBOutlet weak var mTax: UILabel!
    @IBOutlet weak var mHandingFree: UILabel!
    @IBOutlet weak var mMoneylabel: UILabel!
    @IBOutlet weak var mswitchlabel: UILabel!
    @IBOutlet weak var mbutton: UIButton!

    @IBOutlet weak var mtotal: UILabel!
    var isBig = true
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "期貨獲利計算"
        sellnum.text = "1000"
        buynum.text = "1000"
        
        buyprice.keyboardType = .numberPad
        sellprice.keyboardType = .numberPad
        buynum.keyboardType = .numberPad
        sellnum.keyboardType = .numberPad
        
     if(mSwurch.isOn){
        mswitchlabel.text = "大台"
        maintain.text = "70,000"
        mMoneylabel.text = "91,000"

              
          }else{
        mswitchlabel.text = "小台"
        maintain.text = "17,500"
        mMoneylabel.text = "22,750"

          }

        // Do any additional setup after loading the view.
        
        buyprice.delegate = self
        sellprice.delegate = self
        buynum.delegate = self
        sellnum.delegate = self
        
        
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {
        if(sender.isOn){
            isBig = true
            mswitchlabel.text = "大台"
            maintain.text = "70,000"
            mMoneylabel.text = "91,000"
            mTax.text = ""
            mHandingFree.text = ""
            }else{
            
            isBig = false
            mswitchlabel.text = "小台"
            maintain.text = "17,500"
            mMoneylabel.text = "22,750"
            mTax.text = ""
            mHandingFree.text = ""
        }
        
    }
    @IBAction func mCalculationButton(_ sender: Any){
        if(buyprice.text!.isEmpty && buynum.text!.isEmpty
            && sellprice.text!.isEmpty && sellnum.text!.isEmpty){
        
    setToast(s: "請勿輸入空值")

    }else{
            /*
             速算法：
             大台指數直接除250 手續費 50
             小台指數直接除1000  25
             選擇權成交價直接除20
             */
            //買入價格
            var buypriceInt :Int = Int(buyprice.text!)!
            //賣出價格
            var sellpircieInt : Int = Int(sellprice.text!)!
            //買入數量
            var buynumInt :Int = Int(buynum.text!)!
            //賣出數量
            var sellnumInt :Int = Int(sellnum.text!)!
            // 價錢
            var price : Int = sellpircieInt  - buypriceInt
            //數量
            var num = sellnumInt - buynumInt
            // 總價錢
            var total = price * num
            if(isBig){
                setToast(s: "大台")
                var money = ((buypriceInt/250) * buynumInt ) +
                    ((sellpircieInt/250)*sellnumInt)
                mTax.text = String(money)
                var hand = (buynumInt + sellnumInt ) * 50
                mHandingFree.text = String(hand)
                
                var total = (((sellpircieInt - buypriceInt) * 200) * sellnumInt ) - money - hand
            mtotal.text = String(total)

                
            }else{
                setToast(s: "小台")
                var money = ((buypriceInt/1000) * buynumInt ) +
                        ((sellpircieInt/1000)*sellnumInt)
                mTax.text = String(money)
                var hand = (buynumInt + sellnumInt ) * 25
                mHandingFree.text = String(hand)
                       var total = (((sellpircieInt - buypriceInt) * 50) * sellnumInt ) - money - hand
                mtotal.text = String(total)

        }
        
    }
    
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
