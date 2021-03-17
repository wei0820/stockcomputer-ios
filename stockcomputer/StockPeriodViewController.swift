//
//  StockPeriodViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/10/23.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
class StockPeriodViewController: MGoogleADViewController {

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
