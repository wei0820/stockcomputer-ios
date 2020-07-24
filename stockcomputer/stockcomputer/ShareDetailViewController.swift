//
//  ShareDetailViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/7/22.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit

class ShareDetailViewController: MGoogleADViewController {
    var id :String = ""
    var message :String = ""
    var name :String = ""
    var number :String = ""
    var url :String = ""
    var url_2 :String = ""
    var url_3 :String = ""
    var uuid : String = ""
    var date : String = ""
    
    @IBAction func unlikebtn(_ sender: Any) {
    }
    
    @IBOutlet weak var unlikelabe: UILabel!
    
    @IBAction func likebtn(_ sender: Any) {
    }
    
    @IBOutlet weak var likelabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imag: UIImageView!
    
    @IBOutlet weak var image_2: UIImageView!
    @IBOutlet weak var image_3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
  
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        numberLabel.text = number
        nameLabel.text = name
        messageLabel.text = message
        dateLabel.text = date
        
        
        
        setImage(photo: url, imgeview: imag)
        setImage(photo: url_2, imgeview: image_2)
        setImage(photo: url_3, imgeview: image_3)


        
    }
    
    func setImage(photo:String,imgeview :UIImageView){
        if photo != "" {
            DispatchQueue.global(qos: .userInitiated).async {
                  let imageData:NSData = NSData(contentsOf:URL(string: photo)! )!
                       // When from background thread, UI needs to be updated on main_queue
                       DispatchQueue.main.async {
                           let image = UIImage(data: imageData as Data)
                           imgeview.image = image
                       }
                   }
            
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

}
