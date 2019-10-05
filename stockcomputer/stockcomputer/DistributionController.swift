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
import Kanna
import Alamofire
class DistributionController: MUIViewController ,GADBannerViewDelegate  ,UITextFieldDelegate  ,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    var url = "https://tw.stock.yahoo.com/d/i/fgbuy_tse_w.html"

    @IBOutlet weak var nowprice: UILabel!
    @IBAction func clear_btn(_ sender: Any) {
        price.text = ""
        price.placeholder = ""
        money.text = ""
        money.placeholder = ""
        son.text = ""
        son.placeholder = ""
        nowprice.text = ""
        
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
        test()
        // Do any additional setup after loading the view.
//
//
//
//        if let user = Auth.auth().currentUser {
//            uid = user.uid
//        }
 
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

                    })
                }
            }
            dismiss(animated: true, completion: nil)
        
    }
}
    
    func test(){
        Alamofire.request("https://www.wantgoo.com/global/stockindex?StockNo=VIX&c=0").responseString { response in
            if let html = response.result.value {
                self.parseTaiwanBankHTML(url: html)
            }
        }
    
}
    func parseTaiwanBankHTML(url: String) {
//        print ("url", url)
      ////tbody[class='tb-stock tb-link']|//tbody|//tr|//td
        ////*[@id='fm']/div[4]/div[8]/div[1]/div/div/table/tbody/tr[2]
        if let doc = try? Kanna.HTML(html: url, encoding: String.Encoding.utf8) {
            for rate in doc.xpath("//*[@id='topBasic']/div[2]/div[1]/span[1]") {
                
                print ("台灣銀行 泰銖賣匯", rate.text!)
                
            }
            for rate in doc.xpath("//*[@id='topBasic']/div[2]/div[1]/span[3]") {
                
                print ("台灣銀行 泰銖賣匯", rate.text!)
                
            }

            for rate in doc.xpath("//*[@id='topBasic']/div[2]/div[1]/span[2]") {
                
                print ("台灣銀行 泰銖賣匯", rate.text!)

            }

}
    }
    
  
}
