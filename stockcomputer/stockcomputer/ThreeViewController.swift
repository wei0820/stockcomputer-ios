//
//  ThreeViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/5/13.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import SwiftSoup

class ThreeViewController: MGoogleADViewController {
    @IBOutlet weak var putcallText: UILabel!
    var array :Array<String> = []
     var array_futures :Array<String> = []
    var array_Small :Array<String> = []

     var document: Document = Document.init("")

    @IBOutlet var shareView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        array = GetStockPriceManager.getThree()
        array_futures = GetStockPriceManager.getOpenPosition()
        setThreeDate()
        setFuturesLabel()
        getSmall()
        getPutCall()
        setScreenName(screenName: "三大法人買賣超", screenClassName: "ThreeViewController")
    }
    func setThreeDate(){
        if(array.count != 0){
            three_label_1.text = "日期:" + array[0]
            three_label_2.text = "外資:" + array[1]
            three_label_3.text = "投信:" + array[2]
            three_label_4.text = "自營商:" + array[3]
            three_label_5.text = "合計:" + array[6]

        }
    }
    func setFuturesLabel(){
        if(array_futures.count != 0){
            
            futures_label_1.text = "日期:" + array_futures[0]
            futures_label_2.text = "外資:" + array_futures[1]
            futures_label_3.text = "投信:" + array_futures[2]
            futures_label_4.text = "自營商:" + array_futures[3]
            futures_label_5.text = "合計:" + array_futures[4]

            
            
        }
    }
    
    func getSmall(){
//var text_1 = try elements.get(5).select("span.val").get(0).text()
            //https://www.macromicro.me/collections/46/tw-stock-relative/348/tw-put-call-ratio
               guard let url = URL(string: "https://www.macromicro.me/charts/20069/tw-mtx-long-to-short-ratio-of-individual-player" ?? "") else {
                
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
                    
                       let elements: Elements = try document.select("div.stat-val" ?? "")
                 //transform it into a local object (Item)
//
//                                 for th in try elements.select("span"){
//                                    print("Jack",try th.text())
//                                    array_Small.append(try th.text())
//
//                                 }
                    var text_1 = try elements.select("span").get(0).text()
                    var text_2 = try elements.select("span").get(1).text()
                  

                    small_1.text = text_1 + text_2
                    if(text_1.contains("-")){
                        small_2.text = "散戶偏空,多數做空"
                        small_2.textColor = UIColor.green
                        small_1.textColor = UIColor.green

                    }else{
                        small_2.text = "散戶偏多,多數做多"
                        small_2.textColor = UIColor.red
                        small_1.textColor = UIColor.red


                    }
                    
                   } catch let error {
                   }
                   
                   
               } catch let error {
                   // an error occurred
               }
           
    }
    
    
    
      func getPutCall(){
                
                   guard let url = URL(string: "https://www.macromicro.me/collections/18/tw-market-relative/348/tw-put-call-ratio" ?? "") else {
                    
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
                        
                           let elements: Elements = try document.select("div.stat-val" ?? "")
                        var text_1 = try elements.get(5).select("span.val").get(0).text()
                        
                        putcallText.text = text_1
                        
                       } catch let error {
                       }
                       
                       
                   } catch let error {
                       // an error occurred
                   }
               
        }
    
    @IBAction func close(_ sender: Any) {
        dissmissView()
//        self.share()
    }
    @IBOutlet weak var three_label_5: UILabel!
    @IBOutlet weak var three_label_4: UILabel!
    @IBOutlet weak var three_label_3: UILabel!
    @IBOutlet weak var three_label_2: UILabel!

    @IBOutlet weak var three_label_1: UILabel!

    
    @IBOutlet weak var futures_label_1: UILabel!
    
    @IBOutlet weak var futures_label_2: UILabel!
    
    @IBOutlet weak var futures_label_5: UILabel!
    @IBOutlet weak var futures_label_4: UILabel!
    @IBOutlet weak var futures_label_3: UILabel!
    
    
    
    @IBOutlet weak var small_1: UILabel!
    
    @IBOutlet weak var small_2: UILabel!
    
    func share(){
           let renderer = UIGraphicsImageRenderer(size: shareView.bounds.size)
           let image = renderer.image(actions: { (context) in
              shareView.drawHierarchy(in: shareView.bounds, afterScreenUpdates: true)
        })
           let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
           present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func sharebutton(_ sender: Any) {
        self.share()
    }
    
    
}
