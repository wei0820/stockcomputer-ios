//
//  StockListViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/3/17.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class StockListViewController: MGoogleADViewController , UITableViewDataSource, UITableViewDelegate {
    var itemName:Array<StockData> = Array()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for:indexPath)
        cell.textLabel?.text = itemName[indexPath.row].title
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        itemName = GetStockPriceManager.get()
        
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

}
