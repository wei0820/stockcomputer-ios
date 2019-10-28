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
import JGProgressHUD
import GoogleMobileAds

class NowStockPriceViewController: MGoogleADViewController ,UITabBarDelegate,GADRewardBasedVideoAdDelegate{
    var i = 0
    var j = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "即時選股"
        if(userDefaults.value(forKey: "look") != nil){
            i = userDefaults.value(forKey: "look") as! Int
        }else{
            i = 0
        }
        getNow()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
        
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
    var hud :JGProgressHUD?
    
    func getNow(){
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = "Loading"
        hud?.show(in: self.view)
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
                        if((rate.text?.contains("▼"))!){
                            self.lb_4.textColor = UIColor.green
                            self.lb_3.textColor = UIColor.green
                        }else{
                            self.lb_4.textColor = UIColor.red
                            self.lb_3.textColor = UIColor.red
                            
                        }
                        
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
                        if((rate.text?.contains("▼"))!){
                            self.lb_8.textColor = UIColor.green
                            self.lb_7.textColor = UIColor.green
                        }else{
                            self.lb_8.textColor = UIColor.red
                            self.lb_7.textColor = UIColor.red
                            
                        }
                        
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
                        if((rate.text?.contains("▼"))!){
                            self.lb_12.textColor = UIColor.green
                            self.lb_11.textColor = UIColor.green
                            
                        }else{
                            self.lb_12.textColor = UIColor.red
                            self.lb_11.textColor = UIColor.red
                            
                        }
                        
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
                        if((rate.text?.contains("▼"))!){
                            self.lb_16.textColor = UIColor.green
                            self.lb_15.textColor = UIColor.green
                            
                        }else{
                            self.lb_16.textColor = UIColor.red
                            self.lb_15.textColor = UIColor.red
                            
                            
                        }
                        
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
                        if((rate.text?.contains("▼"))!){
                            self.lb_20.textColor = UIColor.green
                            self.lb_19.textColor = UIColor.green
                            
                        }else{
                            self.lb_20.textColor = UIColor.red
                            self.lb_19.textColor = UIColor.red
                            
                        }
                        
                    }
                    for rate in doc.xpath("//*[@id='mainCol']/div[1]/div[1]/span/time") {
                        print("========")
                        print(rate.text)
                        self.time.text = rate.text!
                    }
                }
                
                
                
                
            }
        }
        hud?.dismiss(afterDelay: 3.0)
        
    }
    func getNow2(){
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = "Loading"
        hud?.show(in: self.view)
        print("========")
        ////*[@id="tabRT1"]/table/tbody/tr[1]/td[2]
        Alamofire.request("https://www.wantgoo.com").responseString { response in
            if let html = response.result.value {
                if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[1]/td[2]") {
                        self.lb_1.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[1]/td[3]") {
                        self.lb_2.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[1]/td[4]") {
                        self.lb_3.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[1]/td[5]") {
                        self.lb_4.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_4.textColor = UIColor.green
                            self.lb_3.textColor = UIColor.green
                        }else{
                            self.lb_4.textColor = UIColor.red
                            self.lb_3.textColor = UIColor.red
                            
                        }
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[2]/td[2]") {
                        self.lb_5.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[2]/td[3]") {
                        self.lb_6.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[2]/td[4]") {
                        self.lb_7.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[2]/td[5]") {
                        self.lb_8.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_8.textColor = UIColor.green
                            self.lb_7.textColor = UIColor.green
                        }else{
                            self.lb_8.textColor = UIColor.red
                            self.lb_7.textColor = UIColor.red
                            
                        }
                    }
                    
                    
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[3]/td[2]") {
                        self.lb_9.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[3]/td[3]") {
                        self.lb_10.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[3]/td[4]") {
                        self.lb_11.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[3]/td[5]") {
                        self.lb_12.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_12.textColor = UIColor.green
                            self.lb_11.textColor = UIColor.green
                            
                        }else{
                            self.lb_12.textColor = UIColor.red
                            self.lb_11.textColor = UIColor.red
                            
                        }
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[4]/td[2]") {
                        self.lb_13.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[4]/td[3]") {
                        self.lb_14.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[4]/td[4]") {
                        self.lb_15.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[4]/td[5]") {
                        self.lb_16.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_16.textColor = UIColor.green
                            self.lb_15.textColor = UIColor.green
                            
                        }else{
                            self.lb_16.textColor = UIColor.red
                            self.lb_15.textColor = UIColor.red
                            
                            
                        }
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[5]/td[2]") {
                        self.lb_17.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[5]/td[3]") {
                        self.lb_18.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[5]/td[4]") {
                        self.lb_19.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT2']/table/tbody/tr[5]/td[5]") {
                        self.lb_20.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_20.textColor = UIColor.green
                            self.lb_19.textColor = UIColor.green
                            
                        }else{
                            self.lb_20.textColor = UIColor.red
                            self.lb_19.textColor = UIColor.red
                            
                        }
                    }
                    for rate in doc.xpath("//*[@id='mainCol']/div[1]/div[1]/span/time") {
                        print("========")
                        print(rate.text)
                        self.time.text = rate.text!
                    }
                }
                
                
                
                
            }
        }
        hud?.dismiss(afterDelay: 3.0)
        
        
    }
    func getNow3(){
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = "Loading"
        hud?.show(in: self.view)
        print("========")
        ////*[@id="tabRT1"]/table/tbody/tr[1]/td[2]
        Alamofire.request("https://www.wantgoo.com").responseString { response in
            if let html = response.result.value {
                if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[1]/td[2]") {
                        self.lb_1.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[1]/td[3]") {
                        self.lb_2.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[1]/td[4]") {
                        self.lb_3.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[1]/td[5]") {
                        self.lb_4.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_4.textColor = UIColor.green
                            self.lb_3.textColor = UIColor.green
                        }else{
                            self.lb_4.textColor = UIColor.red
                            self.lb_3.textColor = UIColor.red
                            
                        }
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[2]/td[2]") {
                        self.lb_5.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[2]/td[3]") {
                        self.lb_6.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[2]/td[4]") {
                        self.lb_7.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[2]/td[5]") {
                        self.lb_8.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_8.textColor = UIColor.green
                            self.lb_7.textColor = UIColor.green
                        }else{
                            self.lb_8.textColor = UIColor.red
                            self.lb_7.textColor = UIColor.red
                            
                        }
                    }
                    
                    
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[3]/td[2]") {
                        self.lb_9.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[3]/td[3]") {
                        self.lb_10.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[3]/td[4]") {
                        self.lb_11.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[3]/td[5]") {
                        self.lb_12.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_12.textColor = UIColor.green
                            self.lb_11.textColor = UIColor.green
                            
                        }else{
                            self.lb_12.textColor = UIColor.red
                            self.lb_11.textColor = UIColor.red
                            
                        }
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[4]/td[2]") {
                        self.lb_13.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[4]/td[3]") {
                        self.lb_14.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[4]/td[4]") {
                        self.lb_15.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[4]/td[5]") {
                        self.lb_16.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_16.textColor = UIColor.green
                            self.lb_15.textColor = UIColor.green
                            
                        }else{
                            self.lb_16.textColor = UIColor.red
                            self.lb_15.textColor = UIColor.red
                            
                            
                        }
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[5]/td[2]") {
                        self.lb_17.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[5]/td[3]") {
                        self.lb_18.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[5]/td[4]") {
                        self.lb_19.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT3']/table/tbody/tr[5]/td[5]") {
                        self.lb_20.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_20.textColor = UIColor.green
                            self.lb_19.textColor = UIColor.green
                            
                        }else{
                            self.lb_20.textColor = UIColor.red
                            self.lb_19.textColor = UIColor.red
                            
                        }
                    }
                    for rate in doc.xpath("//*[@id='mainCol']/div[1]/div[1]/span/time") {
                        print("========")
                        print(rate.text)
                        self.time.text = rate.text!
                    }
                }
                
                
                
                
            }
        }
        hud?.dismiss(afterDelay: 3.0)
        
        
    }
    func getNow4(){
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = "Loading"
        hud?.show(in: self.view)
        print("========")
        ////*[@id="tabRT1"]/table/tbody/tr[1]/td[2]
        Alamofire.request("https://www.wantgoo.com").responseString { response in
            if let html = response.result.value {
                if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[1]/td[2]") {
                        self.lb_1.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[1]/td[3]") {
                        self.lb_2.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[1]/td[4]") {
                        self.lb_3.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[1]/td[5]") {
                        self.lb_4.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_4.textColor = UIColor.green
                            self.lb_3.textColor = UIColor.green
                        }else{
                            self.lb_4.textColor = UIColor.red
                            self.lb_3.textColor = UIColor.red
                            
                        }
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[2]/td[2]") {
                        self.lb_5.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[2]/td[3]") {
                        self.lb_6.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[2]/td[4]") {
                        self.lb_7.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[2]/td[5]") {
                        self.lb_8.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_8.textColor = UIColor.green
                            self.lb_7.textColor = UIColor.green
                        }else{
                            self.lb_8.textColor = UIColor.red
                            self.lb_7.textColor = UIColor.red
                            
                        }
                    }
                    
                    
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[3]/td[2]") {
                        self.lb_9.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[3]/td[3]") {
                        self.lb_10.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[3]/td[4]") {
                        self.lb_11.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[3]/td[5]") {
                        self.lb_12.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_12.textColor = UIColor.green
                            self.lb_11.textColor = UIColor.green
                            
                        }else{
                            self.lb_12.textColor = UIColor.red
                            self.lb_11.textColor = UIColor.red
                            
                        }
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[4]/td[2]") {
                        self.lb_13.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[4]/td[3]") {
                        self.lb_14.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[4]/td[4]") {
                        self.lb_15.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[4]/td[5]") {
                        self.lb_16.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_16.textColor = UIColor.green
                            self.lb_15.textColor = UIColor.green
                            
                        }else{
                            self.lb_16.textColor = UIColor.red
                            self.lb_15.textColor = UIColor.red
                            
                            
                        }
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[5]/td[2]") {
                        self.lb_17.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[5]/td[3]") {
                        self.lb_18.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[5]/td[4]") {
                        self.lb_19.text = rate.text!
                        
                    }
                    for rate in doc.xpath("//*[@id='tabRT4']/table/tbody/tr[5]/td[5]") {
                        self.lb_20.text = rate.text!
                        if((rate.text?.contains("▼"))!){
                            self.lb_20.textColor = UIColor.green
                            self.lb_19.textColor = UIColor.green
                            
                        }else{
                            self.lb_20.textColor = UIColor.red
                            self.lb_19.textColor = UIColor.red
                            
                        }
                    }
                    for rate in doc.xpath("//*[@id='mainCol']/div[1]/div[1]/span/time") {
                        print("========")
                        print(rate.text)
                        self.time.text = rate.text!
                    }
                }
                
                
                
                
            }
        }
        hud?.dismiss(afterDelay: 3.0)
        
        
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            i+=1
            if i >= j{
                self.setAlert()
            }else{
                getNow()

            }
            userDefaults.set(i, forKey: "look")
            break
        case 2:
            i+=1
            if i >= j{
                self.setAlert()
            }else{
                getNow2()

            }
            userDefaults.set(i, forKey: "look")

            break
        case 3:
            i+=1
            if i >= j{
                self.setAlert()
            }else{
                getNow3()

            }
            userDefaults.set(i, forKey: "look")

            break
        case 4:
            i+=1
            if i >= j{
                self.setAlert()
            }else{
                getNow4()

            }
            userDefaults.set(i, forKey: "look")

            break
            
        default:
            Toast.init(text: "").show()
            
        }
    }
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        Toast.init(text: "重置完畢！請重新點選").show()
        i = 0;
        userDefaults.set(i, forKey: "look")

    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad has completed.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }
    
    func setAlert(){
        let controller = UIAlertController(title: "今日已達上限", message: "是否觀看影片重置?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default) { (_) in
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            }
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
}
