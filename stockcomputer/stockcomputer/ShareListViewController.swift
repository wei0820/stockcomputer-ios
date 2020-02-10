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

        // Do any additional setup after loading the view.



        let actionButton = JJFloatingActionButton()

        actionButton.addItem(title: "item 1", image: UIImage(named: "create")?.withRenderingMode(.alwaysTemplate)) { item in
            print("actionButton","item1")


        }

        actionButton.addItem(title: "item 2", image: UIImage(named: "create")?.withRenderingMode(.alwaysTemplate)) { item in
            
            print("actionButton","item2")

          // do something
        }

        view.addSubview(actionButton)
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

}
