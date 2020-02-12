//
//  UiManager.swift
//  stockcomputer
//
//  Created by oneplay on 2020/2/12.
//  Copyright © 2020 jackpan. All rights reserved.
//

import Foundation

import UIKit

class UiManager {
    
    static func getUUID() -> String{
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        return uuid
    }
    
}
