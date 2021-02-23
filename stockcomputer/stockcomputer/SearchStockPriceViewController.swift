//
//  SearchStockPriceViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2021/2/17.
//  Copyright © 2021 jackpan. All rights reserved.
//

import UIKit

class SearchStockPriceViewController: MGoogleADViewController ,UITextFieldDelegate{
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var buyText: UITextField!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        searchText.delegate = self
        buyText.delegate = self
        searchText.keyboardType = .decimalPad
        buyText.keyboardType = .decimalPad
        


    }
    
    @IBAction func closeView(_ sender: Any) {
        dissmissView()
    }
    
    @IBAction func cal_button(_ sender: Any) {
    }
}
