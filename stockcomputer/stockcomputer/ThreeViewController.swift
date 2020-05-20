//
//  ThreeViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/5/13.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class ThreeViewController: MGoogleADViewController {
    var array :Array<String> = []
     var array_futures :Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
         array = GetStockPriceManager.getThree()
        array_futures = GetStockPriceManager.getOpenPosition()
        setThreeDate()
        setFuturesLabel()


        // Do any additional setup after loading the view.
    }
    func setThreeDate(){
        if(array.count != 0){
            three_label_1.text = "日期:" + array[0]
            three_label_2.text = "外資:" + array[1]
            three_label_3.text = "投信:" + array[2]
            three_label_4.text = "自營商:" + array[3]
            three_label_5.text = "合計:" + array[6]

        }
    }
    func setFuturesLabel(){
        if(array_futures.count != 0){
            
            futures_label_1.text = "日期:" + array_futures[0]
            futures_label_2.text = "外資:" + array_futures[1]
            futures_label_3.text = "投信:" + array_futures[2]
            futures_label_4.text = "自營商:" + array_futures[3]
            futures_label_5.text = "合計:" + array_futures[4]

            
            
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dissmissView()
    }
    @IBOutlet weak var three_label_5: UILabel!
    @IBOutlet weak var three_label_4: UILabel!
    @IBOutlet weak var three_label_3: UILabel!
    @IBOutlet weak var three_label_2: UILabel!

    @IBOutlet weak var three_label_1: UILabel!

    
    @IBOutlet weak var futures_label_1: UILabel!
    
    @IBOutlet weak var futures_label_2: UILabel!
    
    @IBOutlet weak var futures_label_5: UILabel!
    @IBOutlet weak var futures_label_4: UILabel!
    @IBOutlet weak var futures_label_3: UILabel!
}