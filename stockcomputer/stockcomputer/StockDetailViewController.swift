//
//  StockDetailViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/3/17.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class StockDetailViewController: MGoogleADViewController {
    var detail : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("jack",detail)
        // Do any additional setup after loading the view.
        label_detail.text = detail
    }
    
    @IBOutlet weak var label_detail: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
