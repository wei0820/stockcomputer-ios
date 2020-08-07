//
//  WarrantViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/8/7.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class WarrantViewController: MGoogleADViewController {
    @IBOutlet weak var buypriceTF: UITextField!
    
    @IBOutlet weak var SellpricveTF: UITextField!
    
    @IBOutlet weak var buyNumTf: UITextField!
    
    @IBOutlet weak var sellNumTF: UITextField!
    
    @IBOutlet weak var Label_1: UILabel!
    
    @IBOutlet weak var label_2: UILabel!
    
    @IBOutlet weak var label_3: UILabel!
    
    @IBOutlet weak var Label_4: UILabel!
    
    @IBOutlet weak var label_5: UILabel!
    
    @IBAction func cal(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func close(_ sender: Any) {
        dissmissView()
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
