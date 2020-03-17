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

   static  func get(){
        guard let url = URL(string: Url ?? "") else {
                      // an error occurred
              
                      return
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
                         let elements: Elements = try document.select("table.tb-stock.tb-link>tbody>tr" ?? "")
                                 //transform it into a local object (Item)
                                 for element in elements {
                                     let text = try element.text()
                                     if(!text.isEmpty){
                                         print("test",text)
                                     }

                                 }

                             } catch let error {
                             }



                  } catch let error {
                      // an error occurred
                  }
    }
}
