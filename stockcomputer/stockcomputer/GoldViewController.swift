//
//  GoldViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/9/24.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import SwiftSoup

class GoldViewController: MGoogleADViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
           let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for:indexPath)
           cell.textLabel?.text = array[indexPath.row]
           
           return cell
    }
    
   var document: Document = Document.init("")
    var array = Array<String>()
    @IBOutlet weak var label_1: UILabel!
    
    @IBOutlet weak var label_2: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGold()
        getGoldTitle()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
       func getGold() {
            
               guard let url = URL(string: "https://rate.bot.com.tw/gold?Lang=zh-TW" ?? "") else {
                
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
                    
                    let elements: Elements = try document.select("tbody" ?? "")
                    var text_1 = try elements.select("tr").get(0).select("td").get(1).text()
                    var text_2 = try elements.select("tr").get(0).select("td").get(2).text()
                    var text_3 = try elements.select("tr").get(1).select("td").get(1).text()
                    var text_4 = try elements.select("tr").get(1).select("td").get(2).text()
                    label_1.text = text_1  + ":" + text_2
                    label_2.text = text_3  + ":" + text_4

          
                                 
                    
                     
                   } catch let error {
                   }
                   
                   
               } catch let error {
                   // an error occurred
               }
           }

    
    
       func getGoldTitle() {
            
               guard let url = URL(string: "https://rate.bot.com.tw/xrt?Lang=zh-TW" ?? "") else {
                
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
                    
                    let elements: Elements = try document.select("tbody>tr" ?? "")
//
//                    for th in try elements.select("td"){
//                        var text = try th.text()
//                     print("Jack",try th.text())
//                    }

                    
                    let text_1 =  try "美金：" + "\t" + "現金買入:" +  elements.select("td").get(1).text() + "\t" + "現金賣出:" +  elements.select("td").get(2).text()
                    let text_2 =  try "美金：" + "\t" + "即期買入:" +  elements.select("td").get(3).text() + "\t" + "即期賣出:" +  elements.select("td").get(4).text()
                  
                    let text_3 =  try "港幣：" + "\t" + "現金買入:" +  elements.select("td").get(12).text() + "\t" + "現金賣出:" +  elements.select("td").get(13).text()
                    let text_4 =  try "港幣：" + "\t" + "即期買入:" +  elements.select("td").get(14).text() + "\t" + "即期賣出:" +  elements.select("td").get(15).text()
                        
                    let text_5 =  try "日幣：" + "\t" + "現金買入:" +  elements.select("td").get(78).text() + "\t" + "現金賣出:" +  elements.select("td").get(79).text()
                    let text_6 =  try "日幣：" + "\t" + "即期買入:" +  elements.select("td").get(80).text() + "\t" + "即期賣出:" +  elements.select("td").get(81).text()
                    let text_7 =  try "泰幣：" + "\t" + "現金買入:" +  elements.select("td").get(122).text() + "\t" + "現金賣出:" +  elements.select("td").get(123).text()
                    let text_8 =  try "泰幣：" + "\t" + "即期買入:" +  elements.select("td").get(124).text() + "\t" + "即期賣出:" +  elements.select("td").get(125).text()
                   
                    
                    let text_9 =  try "人民幣：" + "\t" + "現金買入:" +  elements.select("td").get(199).text() + "\t" + "現金賣出:" +  elements.select("td").get(200).text()
                    let text_10 =  try "人民幣：" + "\t" + "即期買入:" +  elements.select("td").get(201).text() + "\t" + "即期賣出:" +  elements.select("td").get(202).text()
                    
                    
                    let text_11 =  try "韓元：" + "\t" + "現金買入:" +  elements.select("td").get(166).text() + "\t" + "現金賣出:" +  elements.select("td").get(167).text()
                    let text_12 =  try "韓元：" + "\t" + "即期買入:" +  elements.select("td").get(168).text() + "\t" + "即期賣出:" +  elements.select("td").get(169).text()
                    array.append(text_1)
                    array.append(text_2)
                    array.append(text_3)
                    array.append(text_4)
                    array.append(text_5)
                    array.append(text_6)
                    array.append(text_7)
                    array.append(text_8)
                    array.append(text_9)
                    array.append(text_10)
                    array.append(text_11)
                    array.append(text_12)

                   } catch let error {
                   }
                   
                   
               } catch let error {
                   // an error occurred
               }
           }

}
