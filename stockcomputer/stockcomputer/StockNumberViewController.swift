//
//  StockNumberViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/18.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Toaster
import JGProgressHUD
import SwiftSoup

class StockNumberViewController: MGoogleADViewController, UITextFieldDelegate {
    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab4: UILabel!
    @IBOutlet weak var lab6: UILabel!
    
    @IBOutlet weak var lab5: UILabel!
    @IBOutlet weak var search: UITextField!
    var hud :JGProgressHUD?
     var document: Document = Document.init("")

    @IBAction func closeView(_ sender: Any) {
        dissmissView()
    }
    @IBOutlet weak var lab10: UILabel!
    @IBOutlet weak var lab9: UILabel!
    @IBOutlet weak var lab8: UILabel!
    @IBOutlet weak var lab7: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "資券成數查詢"
        search.delegate = self
        setScreenName(screenName: "資券成數查詢", screenClassName: "StockNumberViewController")

        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func startSearch(_ sender: Any) {
        search.resignFirstResponder()
        getTest(number: search.text!)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func getTest(number :String) {
        if(number.isEmpty){
            Toast.init(text: "請輸入代號").show()
        }else
        {
            hud = JGProgressHUD(style: .dark)
             hud?.textLabel.text = "Loading"
             hud?.show(in: self.view)
                    
                       guard let url = URL(string: "https://www.sinotrade.com.tw/Stock/Stock_3_8_6?code="+number ?? "") else {
                        
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
                            
                               let elements: Elements = try document.select("tbody>tr.odd" ?? "")
                         //transform it into a local object (Item)
            //
            //                             for th in try elements.select("td"){
            //                                print("Jack",try th.text())
            //                             }
                            lab1.text =  try  elements.select("td").get(0).text()
                            lab2.text =  try  elements.select("td").get(1).text()
                            lab3.text =  try  elements.select("td").get(2).text()
                            lab4.text =  try  elements.select("td").get(3).text()
                            lab5.text =  try  elements.select("td").get(4).text()
                            lab6.text =  try  elements.select("td").get(5).text()
                            lab7.text =  try  elements.select("td").get(6).text()
                            lab8.text =  try  elements.select("td").get(7).text()

                            
                             
                           } catch let error {
                           }
                           
                           
                       } catch let error {
                           // an error occurred
                       }
        }
        hud?.dismiss(afterDelay: 3.0)


       }

    
}
