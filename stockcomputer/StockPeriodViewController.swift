//
//  StockPeriodViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/10/23.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
class StockPeriodViewController: MGoogleADViewController {
    
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
    }
    
    
    
    @IBAction func search_button(_ sender: Any) {
        let url:URL?=URL.init(string: "https://www.taifex.com.tw/cht/5/stockMargining")
             UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
    }
    
    
    @IBAction func closeView(_ sender: Any) {
        dissmissView()
    }
    
    @IBAction func cal_view(_ sender: Any) {
    }
    

}
