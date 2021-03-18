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
        
        
           myHandPriceDefaults.set(
            handPrice_TF.text, forKey: "handprice_small")
          myHandPriceDefaults.synchronize()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let url:URL?=URL.init(string: "https://www.taifex.com.tw/cht/5/stockMargining")
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
}
