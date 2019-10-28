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
import Toaster
class NowStockPriceViewController: MGoogleADViewController ,UITabBarDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "即時選股"
        getNow()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var time: UILabel!
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBOutlet weak var lb_1: UILabel!
    @IBOutlet weak var lb_2: UILabel!
    @IBOutlet weak var lb_3: UILabel!
    @IBOutlet weak var lb_4: UILabel!
    @IBOutlet weak var lb_5: UILabel!
    @IBOutlet weak var lb_6: UILabel!
    @IBOutlet weak var lb_7: UILabel!
    @IBOutlet weak var lb_8: UILabel!
    @IBOutlet weak var lb_9: UILabel!
    @IBOutlet weak var lb_10: UILabel!
    @IBOutlet weak var lb_11: UILabel!
    @IBOutlet weak var lb_12: UILabel!
    @IBOutlet weak var lb_13: UILabel!
    @IBOutlet weak var lb_14: UILabel!
    @IBOutlet weak var lb_15: UILabel!
    @IBOutlet weak var lb_16: UILabel!
    @IBOutlet weak var lb_17: UILabel!
    @IBOutlet weak var lb_18: UILabel!
    @IBOutlet weak var lb_19: UILabel!
    @IBOutlet weak var lb_20: UILabel!
    func getNow(){
        print("========")
        ////*[@id="tabRT1"]/table/tbody/tr[1]/td[2]
        Alamofire.request("https://www.wantgoo.com").responseString { response in
            if let html = response.result.value {
                if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[1]/td[2]") {
                        self.lb_1.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[1]/td[3]") {
                        self.lb_2.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[1]/td[4]") {
                        self.lb_3.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[1]/td[5]") {
                        self.lb_4.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[2]/td[2]") {
                        self.lb_5.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[2]/td[3]") {
                        self.lb_6.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[2]/td[4]") {
                        self.lb_7.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[2]/td[5]") {
                        self.lb_8.text = rate.text!
                        
                    }
                    
                    
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[3]/td[2]") {
                        self.lb_9.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[3]/td[3]") {
                        self.lb_10.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[3]/td[4]") {
                        self.lb_11.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[3]/td[5]") {
                        self.lb_12.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[4]/td[2]") {
                        self.lb_13.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[4]/td[3]") {
                        self.lb_14.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[4]/td[4]") {
                        self.lb_15.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[4]/td[5]") {
                        self.lb_16.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[5]/td[2]") {
                        self.lb_17.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[5]/td[3]") {
                        self.lb_18.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[5]/td[4]") {
                        self.lb_19.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT1']/table/tbody/tr[5]/td[5]") {
                        self.lb_20.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='mainCol']/div[1]/div[1]/span/time") {
                        print("========")
                        print(rate.text)
                        self.time.text = rate.text!
                    }
                }
                
                
                
                
            }
        }
        
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            Toast.init(text: "1")
            break
        case 2:
            Toast.init(text: "2")

            break
        case 3:
            Toast.init(text: "3")

            break
        case 4:
            Toast.init(text: "4")

            break
            
        default:
            Toast.init(text: "default")

        }
    }
    
}
