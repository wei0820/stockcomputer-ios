//
//  SellAndPutViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/2/6.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class SellAndPutViewController: MGoogleADViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var buypriceLabel: UILabel!
    @IBOutlet weak var selPriceLabel: UILabel!
    @IBOutlet weak var handPrcie: UILabel!
    @IBOutlet weak var buysellPrice: UILabel!
    @IBOutlet weak var TotalPrice: UILabel!
    @IBAction func Cal_Button(_ sender: Any) {
    }
    @IBOutlet weak var sellnumTF: UITextField!
    
    
    @IBOutlet weak var buynumTF: UITextField!
    
    @IBOutlet weak var buyTF: UITextField!
    

    @IBOutlet weak var sellTF: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
