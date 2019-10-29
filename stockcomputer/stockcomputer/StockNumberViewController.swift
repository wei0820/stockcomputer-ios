//
//  StockNumberViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/18.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Toaster
import Kanna
import Alamofire
import JGProgressHUD

class StockNumberViewController: MGoogleADViewController, UITextFieldDelegate {
    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab4: UILabel!
    @IBOutlet weak var lab6: UILabel!
    
    @IBOutlet weak var lab5: UILabel!
    @IBOutlet weak var search: UITextField!
    var hud :JGProgressHUD?
    
    @IBOutlet weak var lab10: UILabel!
    @IBOutlet weak var lab9: UILabel!
    @IBOutlet weak var lab8: UILabel!
    @IBOutlet weak var lab7: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "資券成數查詢"
        search.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func SearchNumber(s:String){
        if(s.isEmpty){
            Toast.init(text: "請輸入代號").show()
        }else{
            hud = JGProgressHUD(style: .dark)
            hud?.textLabel.text = "Loading"
            hud?.show(in: self.view)
            Alamofire.request("https://www.sinotrade.com.tw/Stock/Stock_3_8_6?code="+s).responseString { response in
                if let html = response.result.value {
                    if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                        for rate in doc.xpath("//*[@id='content']/div[2]/table[2]/tbody/tr/td[5]") {
                            Toast(text:s+","+String( Double(100 - Int(rate.text!)!) * 0.01)).show()
                            
                        }
                    }                         }
            }
        
        hud?.dismiss(afterDelay: 3.0)

        }
        
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
