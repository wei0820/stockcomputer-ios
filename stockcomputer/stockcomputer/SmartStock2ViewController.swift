//
//  SmartStock2ViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/28.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
import Toaster
import JGProgressHUD
class SmartStock2ViewController: MGoogleADViewController ,UITabBarDelegate{

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var lab1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "智慧選股-空方股"

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab4: UILabel!
    
    @IBOutlet weak var lab5: UILabel!
    
    @IBOutlet weak var lab6: UILabel!
    
    @IBOutlet weak var lab7: UILabel!
    
    @IBOutlet weak var lab8: UILabel!
    
    @IBOutlet weak var lab9: UILabel!
    
    @IBOutlet weak var lab10: UILabel!
  
     @IBOutlet weak var lab11: UILabel!
     // MARK: - Navigation

    @IBOutlet weak var lab12: UILabel!
    @IBOutlet weak var lab13: UILabel!
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    @IBOutlet weak var lab14: UILabel!
    @IBOutlet weak var lab15: UILabel!
    
    @IBOutlet weak var lab16: UILabel!
    
    @IBOutlet weak var lab17: UILabel!
    @IBOutlet weak var lab18: UILabel!
    @IBOutlet weak var lab19: UILabel!
    @IBOutlet weak var lab20: UILabel!
}
