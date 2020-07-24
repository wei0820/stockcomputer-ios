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
    @IBOutlet weak var share: UIButton!
    
    @IBAction func sharebtn(_ sender: Any) {
        var shareNumber :String =  "代號" + number
        var shareName :String = "名稱:" + name
        var shareMessage :String = "分享原因:" + message
        var sharePhoto =  URL(string: url)
        var sharePhoto_2 = URL(string: url_2)
        var sharePhoto_3 =  URL(string: url_3)
        var downloadUrl =  "下載連結:https://apps.apple.com/tw/app/%E8%82%A1%E7%A5%A8%E7%8D%B2%E5%88%A9%E8%A8%88%E7%AE%97%E6%A9%9F/id1459476279"


        
        
        let activityViewController = UIActivityViewController(activityItems: [shareNumber,shareName,shareMessage,sharePhoto,sharePhoto_2,sharePhoto_3,downloadUrl], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
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
        numberLabel.text = "代號" + number
        nameLabel.text = "名稱:" + name
        messageLabel.text = "分享原因:" + message
        dateLabel.text = "分享日期:" + date
        
        
        
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
