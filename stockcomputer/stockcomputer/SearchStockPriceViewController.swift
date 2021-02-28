//
//  SearchStockPriceViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2021/2/17.
//  Copyright © 2021 jackpan. All rights reserved.
//

import UIKit
import SwiftSoup

import JGProgressHUD

class SearchStockPriceViewController: MGoogleADViewController ,UITextFieldDelegate{
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var buyText: UITextField!
    var document: Document = Document.init("")
    var hud :JGProgressHUD?

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
            
              let controller = UIAlertController(title: "提示", message: "僅供參考,投資人應獨立判斷,是否開始試算", preferredStyle: .actionSheet)
              let names = [ "是", "否"]
              for name in names {
                  let action = UIAlertAction(title: name, style: .default) { (action) in
                      if (name == "是"){
                        self.getStockPrice(s: self.searchText.text!)
                          
                          
                          
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
        
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = "試算中..."
        hud?.show(in: self.view)
         
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
                    var text_int = Double(buyText.text!)
                    var price_double = Double(text_1)
                    label_1.text = "目前價位:" + text_1
                    label_2.text = "融資斷頭價位約:" + String(format: "%.2f",text_int! * 0.72)
                        + "~" +
                            String(format: "%.2f",text_int! * 0.8)
                    label_3.text = "融券斷頭價位約:" + String(format: "%.2f",text_int! * 1.5)
                    label_4.text = "融資還有可以凹單空間約:" + String(format: "%.2f", (price_double! - (text_int! * 0.72)))  + "~" + String(format: "%.2f", (price_double! - (text_int! * 0.8)))
                    
                    
                    label_5.text = "融券還有可以凹單空間約:" + String(format: "%.2f", ((text_int! * 1.5) - price_double!))
                       
                    
                    
                } catch let error {
                }
                
                
            } catch let error {
                // an error occurred
            }
        hud?.dismiss(afterDelay: 3.0)

        }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if searchText  == textField{
            
            
                   guard let text = textField.text else{
                       return true
                   }
            
                   let textLength = text.characters.count + string.characters.count - range.length
            
                   return textLength<=4
               }
            return true
        }
    
    
    @IBOutlet weak var label_1: UILabel!
    
    @IBOutlet weak var label_2: UILabel!
    
    
    @IBOutlet weak var label_3: UILabel!
    
    @IBOutlet weak var label_4: UILabel!
    @IBOutlet weak var label_5: UILabel!
}
