//
//  CalculationManager.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/17.
//  Copyright © 2019 jackpan. All rights reserved.
//

import Foundation
import Kanna
import Alamofire
import Toaster

class CalculationManager
{
    
    static func getPrice(s :String){
        Alamofire.request("https://www.sinotrade.com.tw/Stock/Stock_3_8_6?code="+s).responseString { response in
            if let html = response.result.value {
                if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                    for rate in doc.xpath("//*[@id='content']/div[2]/table[2]/tbody/tr/td[5]") {
                        print("========")
                                  Toast(text:s+","+String( Double(100 - Int(rate.text!)!) * 0.01)).show()

                    }
                }                         }
        }
        
    }
    
    

    
    
}
