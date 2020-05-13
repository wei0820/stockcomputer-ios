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
        setUIView()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closebtn(_ sender: Any) {
        dissmissView()
    }
    
    @IBOutlet weak var view_1: UIView!
    
    @IBOutlet weak var threeVIew: UIView!
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
    func setUIView(){
        let view1 = UITapGestureRecognizer(target: self, action:  #selector(self.setview1))
        self.view_1.addGestureRecognizer(view1)
        
        let view2 = UITapGestureRecognizer(target: self, action:  #selector(self.setview2))
        self.view_2.addGestureRecognizer(view2)
        
        let view3 = UITapGestureRecognizer(target: self, action:  #selector(self.setview3))
        self.view_3.addGestureRecognizer(view3)
        
        let view4 = UITapGestureRecognizer(target: self, action:  #selector(self.setview4))
        self.view_4.addGestureRecognizer(view4)
        
        let view5 = UITapGestureRecognizer(target: self, action:  #selector(self.setview5))
        self.view_5.addGestureRecognizer(view5)
        
        
        
    }
    @objc func setview1(sender : UITapGestureRecognizer) {
        // Do what you want
        setJump(type: "view1")
    }
    @objc func setview2(sender : UITapGestureRecognizer) {
        // Do what you want
        setJump(type: "view2")
    }
    @objc func setview3(sender : UITapGestureRecognizer) {
        // Do what you want
        setJump(type: "view3")
    }
    @objc func setview4(sender : UITapGestureRecognizer) {
        // Do what you want
        setJump(type: "view4")
    }
    @objc func setview5(sender : UITapGestureRecognizer) {
        // Do what you want
        setJump(type: "view5")
    }
}
