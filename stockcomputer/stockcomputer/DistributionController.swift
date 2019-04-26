//
//  DistributionController.swift
//  stockcomputer
//
//  Created by  JackPan on 2019/4/23.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DistributionController: UIViewController ,GADBannerViewDelegate  ,UITextFieldDelegate  ,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    @IBOutlet weak var nowprice: UILabel!
    @IBAction func clear_btn(_ sender: Any) {
//        price.text = ""
//        price.placeholder = ""
//        money.text = ""
//        money.placeholder = ""
//        son.text = ""
//        son.placeholder = ""
//        nowprice.text = ""
        
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
        let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (Void) in
            
            // 判斷是否可以從相機取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.camera)，並 present UIImagePickerController
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        // 新增一個取消動作，讓使用者可以跳出 UIAlertController
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Void) in
            
            imagePickerAlertController.dismiss(animated: true, completion: nil)
        }
        
        // 將上面三個 UIAlertAction 動作加入 UIAlertController
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
        
        // 當使用者按下 uploadBtnAction 時會 present 剛剛建立好的三個 UIAlertAction 動作與
        present(imagePickerAlertController, animated: true, completion: nil)
        
    }
    @IBOutlet weak var clear: UIButton!
    @IBAction func cal(_ sender: Any) {
        if(price.text?.count != 0){
            if(money.text?.count != 0 && son.text?.count == 0){
                cal_1()
                
            }else if (son.text?.count != 0 && money.text?.count == 0 ){
                 cal_2()
            }
            else if (money.text?.count != 0 && son.text?.count != 0){
                cal_3()
            }
        }
        
    }
    var adBannerView: GADBannerView?
    var uid = ""

    @IBOutlet weak var price: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setAdBanner()
        setKeyKeyboardType()

        // Do any additional setup after loading the view.
        
        
        
        if let user = Auth.auth().currentUser {
            uid = user.uid
        }
        
        var ref: DatabaseReference!
        
       
        
    }
    @IBOutlet weak var son: UITextField!
    @IBOutlet weak var money: UITextField!
    var price_double = 0.0
    func cal_1(){
        //除息前股價＝ 現金股利  + 除權息後新股價
        price_double = Double (price.text!)! - Double(money.text!)!
        nowprice.text = String(price_double)
        son.placeholder = "0.0"
        
    }
    func cal_2(){
        //除權後股價＝ 除權前股價 ／（1＋股票股利 ÷ 10)
        price_double = Double (price.text!)! / (1 + Double(son.text!)! / 10)
        nowprice.text = String(format: "%.2f", price_double)
        money.placeholder = "0.0"

        

    }
    func cal_3(){
        //除權除息後股價＝( 除權前股價 息 - 現金股利)／（1＋股票股利 ÷ 10)
        price_double = ( Double (price.text!)! - Double(money.text!)!) / (1 + (Double(son.text!)! / 10))
        nowprice.text = String(format: "%.2f", price_double)

    }
    
    func setAdBanner(){
        let id = "ca-app-pub-7019441527375550/2358814075"
        adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView!.adUnitID = id
        adBannerView!.delegate = self
        adBannerView!.rootViewController = self
        
        adBannerView!.load(GADRequest())
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    // Called when an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        addBannerViewToView(bannerView)
            }
    
    // Called when an ad request failed.
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print((error.localizedDescription))
    }
    
    // Called just before presenting the user a full screen view, such as a browser, in response to
    // clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before dismissing a full screen view.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just after dismissing a full screen view.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print(#function)
    }
    
    // Called just before the application will background or terminate because the user clicked on an
    // ad that will launch another application (such as the App Store).
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print(#function)
    }
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setKeyKeyboardType(){
        
        price.keyboardType = UIKeyboardType.numbersAndPunctuation
        price.returnKeyType = .done
        
        money.keyboardType = UIKeyboardType.numbersAndPunctuation
        money.returnKeyType = .done
        son.keyboardType = UIKeyboardType.numbersAndPunctuation
        son.returnKeyType = .done
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        
        // 取得從 UIImagePickerController 選擇的檔案
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            selectedImageFromPicker = pickedImage
        }
        // 可以自動產生一組獨一無二的 ID 號碼，方便等一下上傳圖片的命名
        let uniqueString = NSUUID().uuidString
        
        
    
        if let user = Auth.auth().currentUser {
            uid = user.uid
            
            
            // 當判斷有 selectedImage 時，我們會在 if 判斷式裡將圖片上傳
            if let selectedImage = selectedImageFromPicker {
                
                
                let storageRef = Storage.storage().reference().child("\(uniqueString).png")
                
                if let uploadData = selectedImage.pngData() {
                    // 這行就是 FirebaseStorage 關鍵的存取方法。
                    storageRef.putData(uploadData, metadata: nil, completion: { (data, error) in
                        
                        if error != nil {
                            
                            // 若有接收到錯誤，我們就直接印在 Console 就好，在這邊就不另外做處理。
                            print("Error: \(error!.localizedDescription)")
                            return
                        }
                        // 我們可以 print 出來看看這個連結事不是我們剛剛所上傳的照片。
//                        print("Photo Url: \(uploadImageUrl)")
                        storageRef.downloadURL { (url, err) in
                            let path = url?.absoluteString
                      
                            let databaseRef = Database.database().reference(withPath: "ID/\(self.uid)/Profile/Photo")
                            
                            databaseRef.setValue(path, withCompletionBlock: { (error, dataRef) in
                                
                                if error != nil {
                                    
                                    print("Database Error: \(error!.localizedDescription)")
                                }
                                else {
                                    
                                    print("圖片已儲存")
                                }
                                
                            })
                        }
//                        let uploadImageUrl = data?.downloadURL()?.absoluteString
                        // 存放在database
             
                        // 連結取得方式就是：data?.downloadURL()?.absoluteString。
                        
//                        if let uploadImageUrl = data?.downloadURL()?.absoluteString {
//
////                            // 我們可以 print 出來看看這個連結事不是我們剛剛所上傳的照片。
////                            print("Photo Url: \(uploadImageUrl)")
////
////
////                            // 存放在database
////                            let databaseRef = Database.database().reference(withPath: "ID/\(self.uid)/Profile/Photo")
////
////                            databaseRef.setValue(uploadImageUrl, withCompletionBlock: { (error, dataRef) in
////
////                                if error != nil {
////
////                                    print("Database Error: \(error!.localizedDescription)")
////                                }
////                                else {
////
////                                    print("圖片已儲存")
////                                }
////
////                            })
//
//
//                        }
                    })
                }
            }
            dismiss(animated: true, completion: nil)
        
    }
}
}
