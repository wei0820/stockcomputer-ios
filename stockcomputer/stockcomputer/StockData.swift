//
//  StockData.swift
//  stockcomputer
//
//  Created by oneplay on 2020/3/17.
//  Copyright © 2020 jackpan. All rights reserved.
//

import Foundation

class StockData {
    var title :String = ""
    var detail :String = ""
    
     func setTitle(s :String){
       title = s
    }
     func setDetail(d :String){
         detail = d
      }

     func getTitle() -> String{
        return title

    }

     func getDetail() -> String{
        return detail

    }
 
}
