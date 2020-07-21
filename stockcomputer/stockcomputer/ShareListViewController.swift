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


        
    }
    override func viewWillAppear(_ animated: Bool) {
        let reference: DatabaseReference! = Database.database().reference().child("ShareStock").child("ShareStock")
                 
                 reference.queryOrderedByKey().observe(.value, with: { snapshot in
                     if snapshot.childrenCount > 0 {
                         
                         for item in snapshot.children {
                             let data = ShareStockItem(snapshot: item as! DataSnapshot)
                             print("Jack",data.id)
                             print("Jack",data.name)
                            self.shareview.append(data)
                             
                         }
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
        
        actionButton.addItem(title: "歷史紀錄", image: UIImage(named: "menu_black")?.withRenderingMode(.alwaysTemplate)) { item in
            

               
            // do something
        
        }
        
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
        
        actionButton.addItem(title: "規範", image: UIImage(named: "report_black")?.withRenderingMode(.alwaysTemplate)) { item in
        
            // do something
        }
        
        view.addSubview(actionButton)
        actionButton.itemAnimationConfiguration = .circularSlideIn(withRadius: 160)
        actionButton.buttonAnimationConfiguration = .rotation(toAngle: .pi * 3 / 4)
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
        var index = indexPath.row + 1
        cell.textLabel?.text = "分享標的:\t" + shareview[indexPath.row].number + "\t" + shareview[indexPath.row].name
        cell.detailTextLabel?.text =   "分享原因:\t" + shareview[indexPath.row].message
        return cell    }
    
}
