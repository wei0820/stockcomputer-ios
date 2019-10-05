//
//  MUIViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/5.
//  Copyright © 2019 jackpan. All rights reserved.
//

import Foundation
import UIKit
class MUIViewController : UIViewController{
    override func viewDidLoad() {
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    
    
}
