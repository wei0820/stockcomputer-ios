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
class FuturesViewController: MGoogleADViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "期貨獲利計算"
        
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
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {
        if(sender.isOn){
                    mswitchlabel.text = "大台"
            maintain.text = "70,000"
            mMoneylabel.text = "91,000"

                    
                }else{
                    mswitchlabel.text = "小台"
                maintain.text = "17,500"
            mMoneylabel.text = "22,750"


                }
        
    }
    @IBAction func mCalculationButton(_ sender: Any){
        if(buyprice.text!.isEmpty && buynum.text!.isEmpty
            && sellprice.text!.isEmpty && sellnum.text!.isEmpty){
        
    setToast(s: "請勿輸入空值")

    }else{
            var buypriceInt :Int = Int(buyprice.text!)!
            var sellpircieInt : Int = Int(sellprice.text!)!
            var buynumInt :Int = Int(buynum.text!)!
            var sellnumInt :Int = Int(sellnum.text!)!
            var price : Int = sellpircieInt  - buypriceInt
            var num = sellnumInt - buynumInt
            var total = price * num
            
        
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
    
}
