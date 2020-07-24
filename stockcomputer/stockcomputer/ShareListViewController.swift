//
//  ShareListViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/2/10.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import JJFloatingActionButton
import CLImagePickerTool
import FirebaseDatabase

class ShareListViewController: MGoogleADViewController , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableview: UITableView!
    var shareview: [ShareStockItem] = [ShareStockItem]()
          var imageArr = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "股票討論分享區"
        // Do any additional setup after loading the view.
        setActionButton()
        getData()
        
    }
    func  getData(){

        let reference: DatabaseReference! = Database.database().reference().child("ShareStock").child("ShareStock")
                 
        reference.queryOrderedByKey().observe(.value, with: { snapshot in
                     if snapshot.childrenCount > 0 {
                        self.shareview.removeAll()

                         for item in snapshot.children {
                             let data = ShareStockItem(snapshot: item as! DataSnapshot)
                            self.shareview.append(data)
                             
                         }
                        self.shareview.reverse()

                        self.tableview.reloadData()
                         
                     }
                     
                 })
    }

    
    func  setActionButton() -> Void{
        
        let actionButton = JJFloatingActionButton()
        
        actionButton.addItem(title: "新增", image: UIImage(named: "create")?.withRenderingMode(.alwaysTemplate)) { item in
            
            if(self.checkIsMember() == false){
                  let controller = UIAlertController(title: "您的身份為訪客", message:"建議正式登入避免資料消失,是否繼續操作", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "是", style: .default) { (_) in
                    self.setJump(type: "addnews")

                             }
              controller.addAction(okAction)
                let cancelAction = UIAlertAction(title: "否", style: .cancel, handler: nil)
               controller.addAction(cancelAction)
                self.present(controller, animated: true, completion: nil)
            }else{
                
            }

        
            
            
            
        }
        
//        actionButton.addItem(title: "歷史紀錄", image: UIImage(named: "menu_black")?.withRenderingMode(.alwaysTemplate)) { item in
//
//
//
//            // do something
//
//        }
        
        actionButton.addItem(title: "會員資訊", image: UIImage(named: "money_black")?.withRenderingMode(.alwaysTemplate)) { item in
            if(self.checkIsMember() == false){
                let controller = UIAlertController(title: "您的身份是訪客", message:"ID:『"+self.getUserID()+"』", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "是", style: .default,handler: nil)
                controller.addAction(okAction)
      self.present(controller, animated: true, completion: nil)
  }else{
       let controller = UIAlertController(title: "您的身份是會員", message:"ID:『"+self.getUserID()+"』", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "是", style: .default,handler: nil)
                controller.addAction(okAction)
      self.present(controller, animated: true, completion: nil)
  }
            
            
            // do something
        }
        
        actionButton.addItem(title: "發文規範", image: UIImage(named: "report_black")?.withRenderingMode(.alwaysTemplate)) { item in
        let controller = UIAlertController(title: "發文規範", message:"本討論區只提供分享,請勿發表帶風向,人身攻擊,招收會員,招收群組等 違規的文章 如發現違規文章 將刪除該文章", preferredStyle: .alert)
          let okAction = UIAlertAction(title: "好的", style: .default,handler: nil)
                    controller.addAction(okAction)
          self.present(controller, animated: true, completion: nil)
            // do something
        }
        
        view.addSubview(actionButton)
        actionButton.itemAnimationConfiguration = .circularSlideIn(withRadius: 125)
        actionButton.buttonAnimationConfiguration = .rotation(toAngle: .pi * 3 / 3)
        actionButton.buttonAnimationConfiguration.opening.duration = 0.8
        actionButton.buttonAnimationConfiguration.closing.duration = 0.6
        
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56).isActive = true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func setAlertDilog(){
        var  messageStr = "會員等級："+"\n"+"會員發文數:"+"\n"+"會員點數："
        let controller = UIAlertController(title: "會員資訊", message:messageStr, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
        
    }
    // MARK: - DataSource
    // ---------------------------------------------------------------------
    // 設定表格section的列數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shareview.count
    }
    
    // 表格的儲存格設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for:indexPath)
        cell.textLabel?.text = "分享標的:\t" + shareview[indexPath.row].number + "\t" + shareview[indexPath.row].name
        cell.detailTextLabel?.text =   "分享原因:\t" + shareview[indexPath.row].message
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(
              at: indexPath, animated: true)
        performSegue(withIdentifier: "sharedetail", sender: nil)


         
      }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "sharedetail"{
            if let index = tableview.indexPathForSelectedRow{
                let secondCV = segue.destination as! ShareDetailViewController
                secondCV.id =  shareview[index.row].id
                secondCV.name =  shareview[index.row].name
                secondCV.number =  shareview[index.row].number
                secondCV.message =  shareview[index.row].message
                secondCV.url =  shareview[index.row].url
                secondCV.url_2 =  shareview[index.row].url_2
                secondCV.url_3 =  shareview[index.row].url_3
                secondCV.date =  shareview[index.row].date
                
                print("Jack","jump")

                print("Jack",shareview[index.row].date)

                
            }
            
            
        }
         
     }
}
