//
//  NowStockPriceViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/25.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Foundation
import Kanna
import Alamofire
class NowStockPriceViewController: MGoogleADViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "即時選股"
        getNow()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getNow(){
        print("========")

        Alamofire.request("https://www.wantgoo.com").responseString { response in
            if let html = response.result.value {
                if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[1]/td[3]") {
                        print("========")
                        print(rate.text)

                    }
                }                         }
        }
        
    }

}
