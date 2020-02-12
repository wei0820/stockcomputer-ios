//
//  ShareListViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/2/10.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import JJFloatingActionButton
class ShareListViewController: MGoogleADViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "股票討論分享區"
        // Do any additional setup after loading the view.
        setActionButton()
        
        
        
    }
    
    func  setActionButton() -> Void{
        
        let actionButton = JJFloatingActionButton()
        
        actionButton.addItem(title: "新增", image: UIImage(named: "create")?.withRenderingMode(.alwaysTemplate)) { item in
            if(self.checkIsMember() == false){
                self.setMemberAlert()
            }
            
            
        }
        
        actionButton.addItem(title: "歷史紀錄", image: UIImage(named: "menu_black")?.withRenderingMode(.alwaysTemplate)) { item in
            
            if(self.checkIsMember() == false){
                self.setMemberAlert()
            }else{
                self.setAlertDilog()

            }
            // do something
        }
        
        actionButton.addItem(title: "會員資訊", image: UIImage(named: "money_black")?.withRenderingMode(.alwaysTemplate)) { item in
            if(self.checkIsMember() == false){
                self.setMemberAlert()
            }else{
                self.setAlertDilog()
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
    
}
