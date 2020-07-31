//
//  AddNewsViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/7/15.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import CLImagePickerTool
import FirebaseStorage
import FirebaseDatabase
class AddNewsViewController: MGoogleADViewController,UITextFieldDelegate{
    @IBOutlet weak var numbetTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var messageTV: UITextView!
    
    @IBOutlet weak var responseTv: UITextView!
    
    
    @IBOutlet weak var add_btn: UIButton!
    
    
    
    var photoarray: Array<String> = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // superVC 当前的控制器 MaxImagesCount最多选择的照片数量
        responseTv.isEditable = false
    
        numbetTF.clearButtonMode = .whileEditing
        numbetTF.returnKeyType = .done
        numbetTF.keyboardType = .default

        nameTF.clearButtonMode = .whileEditing
        nameTF.returnKeyType = .done
        nameTF.keyboardType = .default
        
        messageTV.keyboardType = .default
        messageTV.returnKeyType = .done
        
        
        numbetTF.delegate = self
        nameTF.delegate = self
        add_btn.isHidden = true

        
  
    }
    
    func closeKeyBoard(){
        numbetTF.resignFirstResponder()
        nameTF.resignFirstResponder()
        messageTV.resignFirstResponder()
    }
    
    // 按下Return後會反應的事件
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            //利用此方式讓按下Return後會Toogle 鍵盤讓它消失
            textField.resignFirstResponder()
            return false
        }
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
     }
    @IBAction func sharebtn(_ sender: Any) {
        closeKeyBoard()
        
        let useid :String = userDefaults.string(forKey: "userID") as! String
        
        if(numbetTF.text == "" || nameTF.text == "" || messageTV.text == ""){
            setToast(s: "請檢查是否有遺漏的！！")

        }else{
            var name : String =  nameTF.text!
            var number :String  = numbetTF.text!
            var message : String = messageTV.text!

            if(photoarray.count == 0){
                setToast(s: "至少上傳一張照片")

            }else if(photoarray.count == 1){
                FirebaseManager.setShareStock(id: useid, number: number, name: name, message: message, url: photoarray[0], url_2: "", url_3: "",like: "0",unlike: "0",usermessage: "")


            }else if(photoarray.count == 2){
                FirebaseManager.setShareStock(id: useid, number: number, name: name, message: message, url: photoarray[0], url_2:photoarray[1], url_3: "",like: "0",unlike: "0",usermessage: "")


            }else if(photoarray.count == 3){
                     FirebaseManager.setShareStock(id: useid, number: number, name: name, message: message, url: photoarray[0], url_2:photoarray[1], url_3: photoarray[2],like: "0",unlike: "0",usermessage: "")

            }
            
            setAlert()
        }
        
       
        

    }
    
    @IBAction func closeview(_ sender: Any) {
        dissmissView()
    }
    @IBAction func upload(_ sender: Any) {
        // 建立一個 UIImagePickerController 的實體
            let imagePickerController = UIImagePickerController()
            
            // 委任代理
            imagePickerController.delegate = self
            
            // 建立一個 UIAlertController 的實體
            // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
            let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)
            
            // 建立三個 UIAlertAction 的實體
            // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
            let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (Void) in
                
                // 判斷是否可以從照片圖庫取得照片來源
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    
                    // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                    imagePickerController.sourceType = .photoLibrary
                    self.present(imagePickerController, animated: true, completion: nil)
                }
            }
      
            
            // 新增一個取消動作，讓使用者可以跳出 UIAlertController
            let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Void) in
                
                imagePickerAlertController.dismiss(animated: true, completion: nil)
            }
            
            // 將上面三個 UIAlertAction 動作加入 UIAlertController
            imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(cancelAction)
            
            // 當使用者按下 uploadBtnAction 時會 present 剛剛建立好的三個 UIAlertAction 動作與
            present(imagePickerAlertController, animated: true, completion: nil)
        }
    }


extension AddNewsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
       didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                var selectedImageFromPicker: UIImage?


         let image = info[.originalImage] as? UIImage
        selectedImageFromPicker = image
        // 可以自動產生一組獨一無二的 ID 號碼，方便等一下上傳圖片的命名
              let uniqueString = NSUUID().uuidString
        let useid :String = userDefaults.string(forKey: "userID") as! String
        
        
        if(self.photoarray.count >= 3 ){
            setToast(s: "超過可以上傳圖片上限！！")
            return
            

                              }

              // 當判斷有 selectedImage 時，我們會在 if 判斷式裡將圖片上傳
              if let selectedImage = selectedImageFromPicker {
                  
                  let storageRef = Storage.storage().reference().child(useid).child("\(uniqueString).png")
                  
                  if let uploadData = selectedImage.pngData() {
                      // 這行就是 FirebaseStroge 關鍵的存取方法。
                      storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in
                          
                          if error != nil {
                              
                              // 若有接收到錯誤，我們就直接印在 Console 就好，在這邊就不另外做處理。
                              return
                          }
                    
                          
                          // 連結取得方式就是：data?.downloadURL()?.absoluteString。
                          storageRef.downloadURL { (url
                              , error) in
                              guard let downloadUrl = url else{
                                 return
                              }
                            self.photoarray.append(downloadUrl.absoluteString)
                            if(self.photoarray.count != 0 ){
                                self.responseTv.text = "已上傳圖片數量:" + String(self.photoarray.count)
                                self.closeKeyBoard()
                                self.add_btn.isHidden = false

                            }
                         
//                            print("Jack",downloadUrl.absoluteString)
                            

                          }
          
                      })
                  }
     }

        
        dismiss(animated: true, completion: nil)
    }
    
    func setAlert(){
        
        let controller = UIAlertController(title: "訊息通知", message:"您的發文已經發布！！", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "好的", style: .default) { (_) in
        self.dissmissView()
                   }
                   controller.addAction(okAction)
                
                   present(controller, animated: true, completion: nil)
    }
    
}
    

