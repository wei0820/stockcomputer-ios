//
//  StockNumberViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/18.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit

class StockNumberViewController: MGoogleADViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "資券成數查詢"

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
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
