//
//  OtherViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/5/6.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class OtherViewController: MGoogleADViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeview(_ sender: Any) {
        dissmissView()
    }
    
    @IBOutlet weak var mView3: UIView!
    @IBOutlet weak var mView2: UIView!
    @IBOutlet weak var mView1: UIView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setUIView(){
        let view1 = UITapGestureRecognizer(target: self, action:  #selector(self.view1Action))
        self.mView1.addGestureRecognizer(view1)
        
        let view2 = UITapGestureRecognizer(target: self, action:  #selector(self.view2Action))
        self.mView2.addGestureRecognizer(view2)
              
        let view3 = UITapGestureRecognizer(target: self, action:  #selector(self.view3Action))
        self.mView3.addGestureRecognizer(view3)

       let v4 = UITapGestureRecognizer(target: self, action:  #selector(self.view4Action))
        self.view4.addGestureRecognizer(v4)
        
        let gold = UITapGestureRecognizer(target: self, action:  #selector(self.goldViewAction))
         self.mGoldView.addGestureRecognizer(gold)
        

        
    }
    @IBOutlet weak var mGoldView: UIView!
    @IBOutlet weak var view4: UIView!
    @objc func view1Action(sender : UITapGestureRecognizer) {
          // Do what you want
          setJump(type: "vc1")
      }
    @objc func view2Action(sender : UITapGestureRecognizer) {
          // Do what you want
          setJump(type: "vc2")
      }
    @objc func view3Action(sender : UITapGestureRecognizer) {
          // Do what you want
          setJump(type: "vc3")
      }
    
    @objc func view4Action(sender : UITapGestureRecognizer) {
          // Do what you want
          setJump(type: "ssf")
      }

    @objc func goldViewAction(sender : UITapGestureRecognizer) {
          // Do what you want
          setJump(type: "gold")
      }
   
}
