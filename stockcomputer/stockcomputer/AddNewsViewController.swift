//
//  AddNewsViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/7/15.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import CLImagePickerTool
class AddNewsViewController: MGoogleADViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // superVC 当前的控制器 MaxImagesCount最多选择的照片数量
  
    }
    

    @IBAction func closeview(_ sender: Any) {
        dissmissView()
    }
    
}
