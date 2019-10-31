//
//  ChartViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/31.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Charts
class ChartViewController: MGoogleADViewController {
    @IBOutlet weak var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightButton(s: "新增資料")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setRightButton(s: String){
        // 導覽列右邊按鈕
        
        let rightButton = UIBarButtonItem(
            title:s,
            style:.plain,
            target:self,
            action:#selector(ViewController.setting))
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton
    }
    @objc func setting() {
  

}
}
