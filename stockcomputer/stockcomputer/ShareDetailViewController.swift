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
    var key : String = ""
    var  like : String  = ""
    var unLike : String = ""
    var usermessage : String = ""
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
//        FirebaseManager.DeleteShareData(id: key)
        var uplike :Int =  Int(unLike)!  + 1
        unlikelabe.text = String(uplike)
        if(Int(unLike)! >= 10){
            
            let controller = UIAlertController(title: "爛文章檢舉提醒", message: "是否要將該文章刪除 ?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好的", style: .default) { (_) in
                FirebaseManager.DeleteShareData(id: self.key)
                self.dissmissView()
            }
            controller.addAction(okAction)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
            
            
            
            
        }else{
            FirebaseManager.updateToFirebase(key: key, id: id, number: number, name: name, message: message, url: url, url_2: url_2, url_3: url_3, like: String(like), unlike: String(uplike) , usermessage: usermessage, date: date, uuid: uuid)
            
        }
        

        
    }
    
    @IBOutlet weak var unlikelabe: UILabel!
    
    @IBAction func likebtn(_ sender: Any) {
        print("Jack",like)
        var uplike :Int =  Int(like)!  + 1
        likelabel.text = String(uplike)

        FirebaseManager.updateToFirebase(key: key, id: id, number: number, name: name, message: message, url: url, url_2: url_2, url_3: url_3, like: String(uplike), unlike: String(unLike) , usermessage: usermessage, date: date, uuid: uuid)


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
        
        likelabel.text = like
        unlikelabe.text = unLike


        
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


}
