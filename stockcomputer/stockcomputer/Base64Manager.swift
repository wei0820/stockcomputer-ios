//
//  Base64Manager.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/5.
//  Copyright © 2019 jackpan. All rights reserved.
//

import Foundation
import UIKit

class Base64Manager{
    static func base64Encoded(url: String) -> String{
        
        return url.base64Decoded()!
    }
    static func base64Decoded(base64EncodedString: String) -> String{
          base64EncodedString.base64Decoded()! // It will return: heroes\
    }
    
    
    
    
    static func convertImageToBase64(_ image: UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
           let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
           return strBase64
    }
    //Get UIImage from base64 string
    static func convertBase64ToImage(_ str: String) -> UIImage {
            let dataDecoded : Data = Data(base64Encoded: str, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
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

//Get Base64 string From UIImage

 
