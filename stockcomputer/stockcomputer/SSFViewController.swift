//
//  SSFViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/5/7.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import SwiftSoup
import JGProgressHUD
import GoogleMobileAds
import SwiftyStoreKit
class SSFViewController: MGoogleADViewController, UITextFieldDelegate {
    var document: Document = Document.init("")
    var array = Array<String>()
    var interstitial: GADInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        input.keyboardType = UIKeyboardType.numbersAndPunctuation
        input.returnKeyType = .done
        input.borderStyle = .roundedRect
        input.delegate = self
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-7019441527375550/5957417692")
        let request = GADRequest()
        interstitial.load(request)
        setScreenName(screenName: "股票期貨查詢", screenClassName: "SSFViewController")

        // Do any additional setup after loading the view.
    }
    @IBAction func close(_ sender: Any) {
        dissmissView()
    }
    @IBAction func inputbtn(_ sender: Any) {
        input.resignFirstResponder()
        if(input.text!.isEmpty){
            setToast(s: "請輸入代號")
        }else{
            hud = JGProgressHUD(style: .dark)
            hud?.textLabel.text = "Loading"
            hud?.show(in: self.view)
            array.removeAll()
            clearLabel()
            getStock_aTitle(s: input.text!)
            if(array.count<=0){
               
                setToast(s: "該股票無期貨")
            }else{
            
                setLabel()

            }
        hud?.dismiss(afterDelay: 3.0)

        }
        
        
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "05c23e4de2a14cad935a56b657dd0698")
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productIds = Set([ "remove_ad_month",
                                       "remove_six_month",
                                       "remove_ad_year"])
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: productIds, inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    print("jack","\(productIds) 有效期限  \(expiryDate)\n\(items)\n")
                  

                case .expired(let expiryDate, let items):
                    print("jack","\(productIds) 已經過期 \(expiryDate)\n\(items)\n")
                           if self.interstitial.isReady {
                                     self.interstitial.present(fromRootViewController: self)
                                            }


                case .notPurchased:
                    print("jack","沒有購買 \(productIds)")
                    if self.interstitial.isReady {
                        self.interstitial.present(fromRootViewController: self)
                               }

                    

                }
            case .error(let error):
                print("jack","Receipt verification failed: \(error)")
            }
        }
      
      

    }
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var label_1: UILabel!
    
    @IBOutlet weak var label_2: UILabel!
    
    @IBOutlet weak var label_3: UILabel!
    
    @IBOutlet weak var label_4: UILabel!
    
    @IBOutlet weak var label_5: UILabel!
    
    @IBOutlet weak var label_6: UILabel!
    
    @IBOutlet weak var label_7: UILabel!
    
    @IBOutlet weak var label_8: UILabel!
    
    @IBOutlet weak var label_9: UILabel!
    @IBOutlet weak var label_10: UILabel!
    @IBOutlet weak var label_11: UILabel!
    
    @IBOutlet weak var label_12: UILabel!
    @IBOutlet weak var label_13: UILabel!
    
    @IBOutlet weak var label_14: UILabel!
    
    @IBOutlet weak var label_15: UILabel!
    var hud :JGProgressHUD?

    func getStock_aTitle(s:String) -> String {
              var title  = ""
                 guard let url = URL(string: "https://histock.tw/stock/future.aspx?no="+s ?? "") else {
                     // an error occurred
                     return title
                 }
                 
                 do {
                     
                     // content of url
                     let html = try String.init(contentsOf: url)
                     
                     // parse it into a Document
                     document = try SwiftSoup.parse(html)
                     // parse css query
                     do {
                         
                         let elements: Elements = try document.select("table.gvTB.mt10>tbody>tr.searchrow.alt-row" ?? "")
                        
                        if(elements.size()<=0){
                            return ""
                        }
                        for i in 1...16{
                            let n = try elements.select("span").get(i).text()
                            array.append(n)
                        }
                      
                     } catch let error {
                     }
                     
                     
                 } catch let error {
                     // an error occurred
                 }
                 return title
             }
    func setLabel(){
        
        label_1.text = "股票:\t" + array[0]
        label_2.text = "到期月份:\t" + array[2]
        label_3.text = "開盤價:\t" + array[3]
        label_4.text = "最高價:\t" + array[4]
        label_5.text = "最低價:\t" + array[5]
        label_6.text = "成交價:\t" + array[6]
        label_7.text = "漲跌價:\t" + array[7]
        label_8.text = "漲跌%:\t\t" + array[8]
        label_9.text = "結算價:\t" + array[9]
        label_10.text = "成交量:\t" + array[10]
        label_11.text = "未平倉:\t" + array[11]
        label_12.text = "最佳買價:\t" + array[12]
        label_13.text = "最佳賣價:\t" + array[13]
        label_14.text = "歷史高價:\t" + array[14]
        label_15.text = "歷史低價:\t" + array[15]


      
    }
    
    func clearLabel(){
         label_1.text = "股票:\t"
         label_2.text = "到期月份:\t"
         label_3.text = "開盤價:\t" 
         label_4.text = "最高價:\t"
         label_5.text = "最低價:\t"
         label_6.text = "成交價:\t"
         label_7.text = "漲跌價:\t"
         label_8.text = "漲跌%:\t\t"
         label_9.text = "結算價:\t"
         label_10.text = "成交量:\t"
         label_11.text = "未平倉:\t"
         label_12.text = "最佳買價:\t"
         label_13.text = "最佳賣價:\t"
         label_14.text = "歷史高價:\t"
         label_15.text = "歷史低價:\t"


       
     }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
         // 開始進入編輯狀態
        func textFieldDidBeginEditing(_ textField: UITextField){
        }
     
        // 可能進入結束編輯狀態
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
     
            return true
        }
     
        // 結束編輯狀態(意指完成輸入或離開焦點)
        func textFieldDidEndEditing(_ textField: UITextField) {
     
                    }
     
        // 按下Return後會反應的事件
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //利用此方式讓按下Return後會Toogle 鍵盤讓它消失
            textField.resignFirstResponder()
            return false
        }
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
     }
    
    

}
