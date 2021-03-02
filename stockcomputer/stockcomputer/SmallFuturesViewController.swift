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
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeView(_ sender: Any) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
    }
    
    @IBAction func cla_btn(_ sender: Any) {
    }
    
    
}
