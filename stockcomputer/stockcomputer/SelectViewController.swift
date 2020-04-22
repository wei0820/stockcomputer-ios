//
//  SelectViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/4/16.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class SelectViewController: MGoogleADViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func closebtn(_ sender: Any) {
        dissmissView()
    }
   
     @IBOutlet weak var view_1: UIView!
    
    @IBOutlet weak var view_2: UIView!
    
    @IBOutlet weak var view_3: UIView!
    
    @IBOutlet weak var view_4: UIView!
    @IBOutlet weak var view_5: UIView!
    
     // MARK: - Navigation
 /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
