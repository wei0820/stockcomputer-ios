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
        let stroyboard = UIStoryboard(name: "Main", bundle: nil);
        let HomeVc = stroyboard.instantiateViewController(withIdentifier: "home")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.window?.rootViewController = HomeVc
    }
    
    @IBAction func cal_button(_ sender: Any) {
        
        if(!searchText.text!.isEmpty && !buyText.text!.isEmpty){
            
              let controller = UIAlertController(title: "提示", message: "僅供參考ㄝ,投資人應獨立判斷,是否開始試算", preferredStyle: .actionSheet)
              let names = [ "是", "否"]
              for name in names {
                  let action = UIAlertAction(title: name, style: .default) { (action) in
                      if (name == "是"){
                      
                          
                          
                          
                      }else{
                          
                      }
                  }
                  controller.addAction(action)
              }
              let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
              controller.addAction(cancelAction)
              present(controller, animated: true, completion: nil)
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }else{
            setToast(s: "請檢查輸入是否有遺漏")
        }
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
