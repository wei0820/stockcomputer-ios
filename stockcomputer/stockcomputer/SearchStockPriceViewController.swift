//
//  SearchStockPriceViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2021/2/17.
//  Copyright © 2021 jackpan. All rights reserved.
//

import UIKit
import SwiftSoup


class SearchStockPriceViewController: MGoogleADViewController ,UITextFieldDelegate{
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var buyText: UITextField!
    var document: Document = Document.init("")

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
    
    
    
    
    
    func getStockPrice(s : String) {
         
            guard let url = URL(string: "https://histock.tw/stock/" + s ?? "") else {
             
             return
                // an error occurred
            }
            
            do {
                
                // content of url
                let html = try String.init(contentsOf: url)
                
                // parse it into a Document
                document = try SwiftSoup.parse(html)
                // parse css query
                do {
                    
                   //div>table#CPHB1_chipAnalysis1_gBuy.tbTable.tb-stock.tbChip>tbody
                 
                 let elements: Elements = try document.select("ul.priceinfo.mt10" ?? "")
                    var text_1 = try elements.select("li.deal>span").text()
                    print("Jack",text_1)
                } catch let error {
                }
                
                
            } catch let error {
                // an error occurred
            }
        }
}
