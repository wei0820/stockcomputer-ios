//
//  GetStockPriceManger.swift
//  stockcomputer
//
//  Created by oneplay on 2020/3/17.
//  Copyright © 2020 jackpan. All rights reserved.
//

import Foundation
import SwiftSoup
class GetStockPriceManager{
    let Url_a : String  = "https://histock.tw/stock/three.aspx?s=a"
    let Url_b : String = "https://histock.tw/stock/three.aspx?s=b"
    let Url_c :String = "https://histock.tw/stock/three.aspx?s=c"
    let broker :String = "https://histock.tw/stock/broker8.aspx"
    static let Url :String = "https://histock.tw/app/table.aspx"
    static var document: Document = Document.init("")
    static var array = Array<StockData>()
    static  func get() -> Array<StockData> {
        guard let url = URL(string: Url ?? "") else {
            // an error occurred
            return array
        }
        
        do {
            
            // content of url
            let html = try String.init(contentsOf: url)
            
            // parse it into a Document
            document = try SwiftSoup.parse(html)
            // parse css query
            do {
                
                //empty old items
                // firn css selector
                let elements: Elements = try document.select("table.tb-stock.tb-link>tbody" ?? "")
                //transform it into a local object (Item)
                for th in try elements.select("tr") {
                    var stock  =  StockData()
                    
                    let th = try th.text()
                    if(!th.isEmpty){
                       
                        stock.setTitle(s:  String(th.split(separator: " ")[0]))
                        print("test", String(th.split(separator: " ")[1]))

                        array.append(stock)
                        
                    }
                    
                }
                //                for element in try elements.select("tr") {
                //
                //
                //
                //                    for td in try elements.select("td") {
                //                        let td = try td.text()
                //                        if(!td.isEmpty){
                //                            print("test",td)
                //
                //
                //                        }
                //                    }
                //
                //                }
                
                
                
                
                
                print("test",array.count)
                
            } catch let error {
            }
            
            
        } catch let error {
            // an error occurred
        }
        return array
    }
}
