//
//  Base64Manager.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/5.
//  Copyright © 2019 jackpan. All rights reserved.
//

import Foundation

class Base64Manager{
    static func base64Encoded(url: String) -> String{
        
        return url.base64Decoded()!
    }
    static func base64Decoded(s:base64EncodedString ) -> String{
        s.base64Decoded() // It will return: heroes

    }
    
}
extension String {
     func base64Encoded() -> String? {
         return data(using: .utf8)?.base64EncodedString()
     }

     func base64Decoded() -> String? {
         guard let data = Data(base64Encoded: self) else { return nil }
         return String(data: data, encoding: .utf8)
     }
 }
 
