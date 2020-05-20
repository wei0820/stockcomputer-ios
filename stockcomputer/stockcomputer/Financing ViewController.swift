//
//  Financing ViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/5/20.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class Financing_ViewController: MGoogleADViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cal(_ sender: Any) {
    }
    @IBOutlet weak var sellMoney: UITextField!
    @IBOutlet weak var buyMoney: UITextField!
    @IBOutlet weak var endTime: UITextField!
    
    @IBOutlet weak var sellNum: UITextField!
    @IBOutlet weak var buyNum: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var label_1: UILabel!

    @IBOutlet weak var label_2: UILabel!
    
    @IBOutlet weak var label_3: UILabel!
    
    
    @IBOutlet weak var label_4: UILabel!
    
    @IBOutlet weak var label_5: UILabel!
    
    /*
    // MARK: - Navigation
     
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func closeview(_ sender: Any) {
        dissmissView()
    }
    
}
