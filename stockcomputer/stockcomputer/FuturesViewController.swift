//
//  FuturesViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/11/27.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
class FuturesViewController: MGoogleADViewController {
    
    @IBOutlet weak var buyprice: UITextField!
    @IBOutlet weak var sellprice: UITextField!
    @IBOutlet weak var buynum: UITextField!
    @IBOutlet weak var sellnum: UITextField!
    @IBOutlet weak var mSwurch: UISwitch!
    
    @IBOutlet var mProfit: UIView!
    @IBOutlet weak var mTax: UILabel!
    @IBOutlet weak var mHandingFree: UILabel!
    @IBOutlet weak var mMoneylabel: UILabel!
    @IBOutlet weak var mswitchlabel: UILabel!
    @IBOutlet weak var mbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "期貨獲利計算"
        test2()
        
     if(mSwurch.isOn){
              mswitchlabel.text = "大台"
              
          }else{
              mswitchlabel.text = "小台"

          }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchChange(_ sender: UISwitch) {
        if(sender.isOn){
                    mswitchlabel.text = "大台"
                    
                }else{
                    mswitchlabel.text = "小台"

                }
        
    }
    @IBAction func mCalculationButton(_ sender: Any){
        if(buyprice.text!.isEmpty && buynum.text!.isEmpty
            && sellprice.text!.isEmpty && sellnum.text!.isEmpty){
        
    setToast(s: "請勿輸入空值")

    }else{
    
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
    
    func test2(){
         Alamofire.request("https://tw.stock.yahoo.com/d/i/major.html").responseString { response in
             if let html = response.result.value {
                 self.parseTaiwanBankHTML2(url: html)
             }
         }
         
     }
    
    func parseTaiwanBankHTML2(url: String) {
        print("========Url===========")
        if let doc = try? Kanna.HTML(html: url, encoding: String.Encoding.utf8) {
            for rate in doc.xpath("/html/body/table[2]/tbody/tr/td/table[2]/tbody/tr[6]/td[2]") {
                print("========")
                print("========",rate.text)
                mMoneylabel.text = rate.text

            }
        }
    }
}
