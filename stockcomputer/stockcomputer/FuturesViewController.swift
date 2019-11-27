//
//  FuturesViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/11/27.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit

class FuturesViewController: MGoogleADViewController {
    
    @IBOutlet weak var buyprice: UITextField!
    @IBOutlet weak var sellprice: UITextField!
    @IBOutlet weak var buynum: UITextField!
    @IBOutlet weak var sellnum: UITextField!
    @IBOutlet weak var mSwurch: UISwitch!
    
    @IBOutlet var mProfit: UIView!
    @IBOutlet weak var mTax: UILabel!
    @IBOutlet weak var mHandingFree: UILabel!
    @IBOutlet weak var mMoneylabel: UILabel!
    @IBOutlet weak var mswitchlabel: UILabel!
    @IBOutlet weak var mbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "期貨獲利計算"

        // Do any additional setup after loading the view.
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
