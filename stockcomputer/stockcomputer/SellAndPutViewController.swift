//
//  SellAndPutViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/2/6.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import Toaster
import Kanna
import Alamofire
import JGProgressHUD
class SellAndPutViewController: MGoogleADViewController {
    var hud :JGProgressHUD?
    @IBOutlet weak var buypriceLabel: UILabel!
    @IBOutlet weak var selPriceLabel: UILabel!
    @IBOutlet weak var handPrcie: UILabel!
    @IBOutlet weak var buysellPrice: UILabel!
    @IBOutlet weak var TotalPrice: UILabel!
    @IBOutlet weak var sellnumTF: UITextField!
    @IBOutlet weak var buynumTF: UITextField!
    @IBOutlet weak var buyTF: UITextField!
    @IBOutlet weak var sellTF: UITextField!
    @IBAction func Cal_Button(_ sender: Any) {
        if(buyTF.text!.isEmpty && buynumTF.text!.isEmpty &&
            sellTF.text!.isEmpty && sellnumTF.text!.isEmpty){
            setToast(s: "請輸入完整內容")
            
        }else{
            //買進成交
            var buypriceInt: Int = (Int(buynumTF.text!)! * Int(buyTF.text!)!) * 50
            buypriceLabel.text = String(buypriceInt)
            //賣出成交
            var sellpriceInt: Int = (Int(sellnumTF.text!)! * Int(sellTF.text!)!) * 50
            selPriceLabel.text = String(sellpriceInt)
            //選擇權成交/20=稅金
            var sellbuymoneyInt : Int = (((Int(buynumTF.text!)! * Int(buyTF.text!)!)/20) + ((Int(sellnumTF.text!)! * Int(sellTF.text!)!)/20))
            buysellPrice.text = String(sellbuymoneyInt)
            var handInt :Int =  (Int(buynumTF.text!)! +  Int(sellnumTF.text!)!) * 20
            handPrcie.text = String (handInt)
            var total : Int = sellpriceInt - buypriceInt - sellbuymoneyInt - handInt
            TotalPrice.text = String(total)
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
}
