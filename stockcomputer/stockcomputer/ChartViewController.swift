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
    var months: [String]!
    var set = Set<String>()
    var mArray = Array<String>()
    var temperatureArray = Array<Int>()
    var axisFormatDelgate: IAxisValueFormatter?
    
    @IBOutlet weak var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightButton(s: "新增資料")
        addDate()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func addDate(){
        print("11111",TimerManager.getNowTime())
        userDefaults.set(TimerManager.getNowTime(), forKey: "NowTime")
        mArray.append(TimerManager.getNowTime())
        let result = Array(Set(mArray))
        result.forEach { (sssss) in
            print("11111",sssss)
        }
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
        setAlert()
        
        
    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        
    }
    
    func setAlert(){
        let controller = UIAlertController(title: "登入", message: "請輸入你在 B12 星球的電話和密碼", preferredStyle: .alert)
        controller.addTextField { (textField) in
            textField.placeholder = "x"
            textField.keyboardType = UIKeyboardType.numberPad
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            let password = controller.textFields?[0].text
            print(password)
            self.temperatureArray.append(Int(password!)!)
            self.updateChartsData()
            
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    func updateChartsData() {
        //生成一個存放資料的陣列，型別是BarChartDataEntry.
        var dataEntries: [BarChartDataEntry] = []
        
        //實作一個迴圈，來存入每筆顯示的資料內容
        for i in 0..<mArray.count {
            //需設定x, y座標分別需顯示什麼東西
            let dataEntry = BarChartDataEntry(x:Double(i),  y:Double(temperatureArray[i]))
            //最後把每次生成的dataEntry存入到dataEntries當中
            dataEntries.append(dataEntry)
        }
        //透過BarChartDataSet設定我們要顯示的資料為何，以及圖表下方的label
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Temperature per month")
        //把整個dataset轉換成可以顯示的BarChartData
        let charData = BarChartData(dataSet: chartDataSet)
        //最後在指定剛剛連結的myView要顯示的資料為charData
        chartView.data = charData
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.mArray)
        chartView.xAxis.granularity = 1
        
        
    }
}
