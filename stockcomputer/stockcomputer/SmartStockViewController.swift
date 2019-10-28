//
//  SmartStockViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/25.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
import Toaster
import JGProgressHUD
class SmartStockViewController: MGoogleADViewController ,UITabBarDelegate{

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab4: UILabel!
    @IBOutlet weak var lab5: UILabel!
    @IBOutlet weak var lab6: UILabel!
    @IBOutlet weak var lab7: UILabel!
    @IBOutlet weak var lab8: UILabel!
    @IBOutlet weak var lab9: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "智慧選股-多方股"
        getNow(s: "tabHTA2")

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var lab10: UILabel!
    
    @IBOutlet weak var lab11: UILabel!
  
     @IBOutlet weak var lab12: UILabel!
    
    @IBOutlet weak var lab13: UILabel!
    // MARK: - Navigation
    @IBOutlet weak var lab14: UILabel!
    
    @IBOutlet weak var lab15: UILabel!
    @IBOutlet weak var lab16: UILabel!
    @IBOutlet weak var lab17: UILabel!
    @IBOutlet weak var lab18: UILabel!
    @IBOutlet weak var lab19: UILabel!
    @IBOutlet weak var lab20: UILabel!
    var hud :JGProgressHUD?

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    func getNow(s:String){
           hud = JGProgressHUD(style: .dark)
              hud?.textLabel.text = "Loading"
              hud?.show(in: self.view)
           print("========")
           ////*[@id="tabRT1"]/table/tbody/tr[1]/td[2]
           Alamofire.request("https://www.wantgoo.com").responseString { response in
               if let html = response.result.value {
                   if let doc = try? Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[1]/td[2]") {
                           self.lab1.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[1]/td[3]") {
                           self.lab2.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[1]/td[4]") {
                        self.lab3.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[1]/td[5]") {
                           self.lab4.text = rate.text!
                           if((rate.text?.contains("▼"))!){
                               self.lab4.textColor = UIColor.green
                               self.lab3.textColor = UIColor.green
                           }else{
                            self.lab4.textColor = UIColor.red
                               self.lab3.textColor = UIColor.red
                               
                           }
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[2]/td[2]") {
                           self.lab5.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[2]/td[3]") {
                           self.lab6.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[2]/td[4]") {
                           self.lab7.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[2]/td[5]") {
                           self.lab8.text = rate.text!
                           if((rate.text?.contains("▼"))!){
                               self.lab8.textColor = UIColor.green
                               self.lab7.textColor = UIColor.green
                           }else{
                               self.lab8.textColor = UIColor.red
                               self.lab7.textColor = UIColor.red
                               
                           }
                           
                       }
                       
                       
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[3]/td[2]") {
                           self.lab9.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[3]/td[3]") {
                           self.lab10.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[3]/td[4]") {
                           self.lab11.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[3]/td[5]") {
                           self.lab12.text = rate.text!
                           if((rate.text?.contains("▼"))!){
                               self.lab12.textColor = UIColor.green
                               self.lab11.textColor = UIColor.green
                               
                           }else{
                            self.lab12.textColor = UIColor.red
                               self.lab11.textColor = UIColor.red
                               
                           }
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[4]/td[2]") {
                           self.lab13.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[4]/td[3]") {
                           self.lab14.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[4]/td[4]") {
                           self.lab15.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[4]/td[5]") {
                           self.lab16.text = rate.text!
                           if((rate.text?.contains("▼"))!){
                               self.lab16.textColor = UIColor.green
                               self.lab15.textColor = UIColor.green

                           }else{
                               self.lab16.textColor = UIColor.red
                               self.lab15.textColor = UIColor.red

                               
                           }
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[5]/td[2]") {
                           self.lab17.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[5]/td[3]") {
                           self.lab18.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[5]/td[4]") {
                           self.lab19.text = rate.text!
                           
                       }
                       for rate in doc.xpath("//*[@id='"+s+"']/table/tbody/tr[5]/td[5]") {
                           self.lab20.text = rate.text!
                           if((rate.text?.contains("▼"))!){
                               self.lab20.textColor = UIColor.green
                               self.lab19.textColor = UIColor.green
                               
                           }else{
                               self.lab20.textColor = UIColor.red
                               self.lab19.textColor = UIColor.red
                               
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
            getNow(s: "tabHTA2")

               break
           case 2:
               getNow(s: "tabHTA1")
               break
           case 3:
               getNow(s: "tabHTA3")

               break
           case 4:
               getNow(s: "tabHTA4")

               break
               
           default:
               Toast.init(text: "").show()
               
           }
       }
}
