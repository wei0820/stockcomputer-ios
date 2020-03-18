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
    static let Url_a : String  = "https://histock.tw/stock/three.aspx?s=a"
    static let Url_b : String = "https://histock.tw/stock/three.aspx?s=b"
    static let Url_c :String = "https://histock.tw/stock/three.aspx?s=c"
   static  let broker :String = "https://histock.tw/stock/broker8.aspx"
    static let Url :String = "https://histock.tw/app/table.aspx"
    static var document: Document = Document.init("")
    static var array = Array<StockData>()
    static var array_foreigninvestment = Array<String>()
    static  func get() -> Array<StockData> {
        array_foreigninvestment.removeAll()
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
                        stock.setDetail(d: String(th.split(separator: " ")[1]))
                        array.append(stock)
                        
                    }
                    
                }
                
            } catch let error {
            }
            
            
        } catch let error {
            // an error occurred
        }
        return array
    }
    
    
    
    static  func getForeigninvestment() -> Array<String> {
        array_foreigninvestment.removeAll()
        guard let url = URL(string: Url_a ?? "") else {
            // an error occurred
            return array_foreigninvestment
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
                let elements: Elements = try document.select("div.tb-outline.outline1>ul.stock-list>li" ?? "")
                //transform it into a local object (Item)
                for th in try elements.select("span.w58.name") {
                    let n = try th.text()
                    if(!n.isEmpty){
                        print("jack",n)
                        array_foreigninvestment.append(n)

                    }

                }
                
            } catch let error {
            }
            
            
        } catch let error {
            // an error occurred
        }
        return array_foreigninvestment
    }
    
    static  func getForeigninvestment_2() -> Array<String> {
        array_foreigninvestment.removeAll()
        guard let url = URL(string: Url_a ?? "") else {
            // an error occurred
            return array_foreigninvestment
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
                let elements: Elements = try document.select("div.tb-outline.outline2>ul.stock-list>li" ?? "")
                //transform it into a local object (Item)
                for th in try elements.select("span.w58.name") {
                    let n = try th.text()
                    if(!n.isEmpty){
                        print("jack",n)
                        array_foreigninvestment.append(n)

                    }

                }
                
            } catch let error {
            }
            
            
        } catch let error {
            // an error occurred
        }
        return array_foreigninvestment
    }
    
    
    static  func getTust() -> Array<String> {
        array_foreigninvestment.removeAll()
        guard let url = URL(string: Url_b ?? "") else {
            // an error occurred
            return array_foreigninvestment
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
                let elements: Elements = try document.select("div.tb-outline.outline1>ul.stock-list>li" ?? "")
                //transform it into a local object (Item)
                for th in try elements.select("span.w58.name") {
                    let n = try th.text()
                    if(!n.isEmpty){
                        print("jack",n)
                        array_foreigninvestment.append(n)

                    }

                }
                
            } catch let error {
            }
            
            
        } catch let error {
            // an error occurred
        }
        return array_foreigninvestment
    }
    
    static  func getTust_2() -> Array<String> {
        array_foreigninvestment.removeAll()
        guard let url = URL(string: Url_b ?? "") else {
            // an error occurred
            return array_foreigninvestment
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
                let elements: Elements = try document.select("div.tb-outline.outline2>ul.stock-list>li" ?? "")
                //transform it into a local object (Item)
                for th in try elements.select("span.w58.name") {
                    let n = try th.text()
                    if(!n.isEmpty){
                        print("jack",n)
                        array_foreigninvestment.append(n)

                    }

                }
                
            } catch let error {
            }
            
            
        } catch let error {
            // an error occurred
        }
        return array_foreigninvestment
    }
    
    
    static  func getEmployed() -> Array<String> {
        array_foreigninvestment.removeAll()
        guard let url = URL(string: Url_c ?? "") else {
            // an error occurred
            return array_foreigninvestment
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
                let elements: Elements = try document.select("div.tb-outline.outline1>ul.stock-list>li" ?? "")
                //transform it into a local object (Item)
                for th in try elements.select("span.w58.name") {
                    let n = try th.text()
                    if(!n.isEmpty){
                        print("jack",n)
                        array_foreigninvestment.append(n)

                    }

                }
                
            } catch let error {
            }
            
            
        } catch let error {
            // an error occurred
        }
        return array_foreigninvestment
    }
    
    static  func getEmployed_2() -> Array<String> {
        array_foreigninvestment.removeAll()
        guard let url = URL(string: Url_c ?? "") else {
            // an error occurred
            return array_foreigninvestment
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
                let elements: Elements = try document.select("div.tb-outline.outline2>ul.stock-list>li" ?? "")
                //transform it into a local object (Item)
                for th in try elements.select("span.w58.name") {
                    let n = try th.text()
                    if(!n.isEmpty){
                        print("jack",n)
                        array_foreigninvestment.append(n)

                    }

                }
                
            } catch let error {
            }
            
            
        } catch let error {
            // an error occurred
        }
        return array_foreigninvestment
    }
}