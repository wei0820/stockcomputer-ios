//
//  SmallFuturesViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2021/3/2.
//  Copyright © 2021 jackpan. All rights reserved.
//

import UIKit

class SmallFuturesViewController: MGoogleADViewController {
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
        
        
    }

    @IBAction func closeView(_ sender: Any) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
    }
    
    @IBAction func cla_btn(_ sender: Any) {
        
        
           myHandPriceDefaults.set(
            handPrice_TF.text, forKey: "handprice_small")
          myHandPriceDefaults.synchronize()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let url:URL?=URL.init(string: "https://www.taifex.com.tw/cht/5/stockMargining")
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
}
