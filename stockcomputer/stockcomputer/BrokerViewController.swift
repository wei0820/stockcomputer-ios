//
//  BrokerViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/3/18.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import JGProgressHUD
class BrokerViewController: MGoogleADViewController , UITableViewDataSource
, UITableViewDelegate ,UITabBarDelegate{
    var itemName:Array<String> = Array()
    var hud :JGProgressHUD?
    
    @IBOutlet weak var tableview: UITableView!
    var name :String = ""
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for:indexPath)
        var index = indexPath.row + 1
        cell.textLabel?.text = String(index) + "\t" + itemName[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleName.text = GetStockPriceManager.getBrokerTitle() + "八大官股銀行買超排行"
        getData()
        
        // Do any additional setup after loading the view.
    }
    func getData(){
        itemName.removeAll()
        hud = JGProgressHUD(style: .dark)
        hud?.textLabel.text = "Loading"
        hud?.show(in: self.view)
        itemName =  GetStockPriceManager.getBroker()
        hud?.dismiss(afterDelay: 3.0)
        tableview.reloadData()
    
    }
    func getData_2(){
        itemName.removeAll()
         hud = JGProgressHUD(style: .dark)
         hud?.textLabel.text = "Loading"
         hud?.show(in: self.view)
         itemName =  GetStockPriceManager.getBroker_2()
         hud?.dismiss(afterDelay: 3.0)
        tableview.reloadData()

     }
     
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBOutlet weak var titleName: UILabel!
    
    @IBAction func closeView(_ sender: Any) {
        dissmissView()
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            setToast(s: "八大官股銀行買超排行")
            titleName.text = GetStockPriceManager.getBrokerTitle() + "八大官股銀行買超排行"
            getData()
            break
        case 2:
            setToast(s: "八大官股銀行賣超排行")
            titleName.text =  GetStockPriceManager.getBrokerTitle() + "八大官股銀行賣超排行"
            getData_2()
            
            
            break
        default:
            
            break
            
        }
    }
}
