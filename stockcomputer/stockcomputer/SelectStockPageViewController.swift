//
//  SelectStockPageViewController.swift
//  stockcomputer
//
//  Created by  JackPan on 2021/4/25.
//  Copyright © 2021 jackpan. All rights reserved.
//

import UIKit

class SelectStockPageViewController: MGoogleADViewController , UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableview: UITableView!
    var itemName:Array<String> = Array()

    var name :String = ""
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return itemName.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cellIdentifier = "Cell"
           let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for:indexPath)
           cell.textLabel?.text = itemName[indexPath.row]
           
           return cell
       }
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(
               at: indexPath, animated: true)
        name = itemName[indexPath.row]
           performSegue(withIdentifier: "stockdetail", sender: nil)


       }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "熱門股票排行"
            
        itemName = ["股利排行","現金殖利率排行","PER排行","現金殖利率排行","現金殖利率排行","獲利排行","由虧轉盈","股東權益報酬率 (ROE)排行","資產報酬率 (ROA)","每股稅後盈餘 (EPS)"]
    }
    

    @IBAction func closeview(_ sender: Any) {
        dissmissView()
    }
    
}
