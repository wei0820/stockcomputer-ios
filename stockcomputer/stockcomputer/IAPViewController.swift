//
//  IAPViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2020/5/26.
//  Copyright © 2020 jackpan. All rights reserved.
//

import UIKit
import StoreKit
import JGProgressHUD

class IAPViewController: UIViewController , SKProductsRequestDelegate,SKPaymentTransactionObserver{
      func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count != 0 {
            print("invalidProductIdentifiers： \(response.invalidProductIdentifiers.description)")
            for product in response.products {
                self.productsArray.append(product)
                productsArray.forEach { (SKProduct) in
                }
                
                
            }
            
            //               tblProducts.reloadData()
        }
        else {
            print("There are no products.")
        }
                hud?.dismiss(afterDelay: 3.0)

    }
    var hud :JGProgressHUD?

    var productIDs: [String] = [String]() // 產品ID(Consumable_Product、Not_Consumable_Product)
    var selectedProductIndex: Int! // 點擊到的購買項目
     var isProgress: Bool = false // 是否有交易正在進行中
     var delegate: IAPurchaseViewControllerDelegate!
     var productsArray: [SKProduct] = [SKProduct]() //  存放 server 回應的產品項目
     
     
    @IBAction func restartbtn(_ sender: Any) {
        let controller = UIAlertController(title: "復原購買", message: "是否復原購買?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "是", style: .default) { (_) in
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func btn1(_ sender: Any) {
        if let url = URL(string: "https://pokemongosharetw.blogspot.com/2020/05/blog-post.html") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func btn2(_ sender: Any) {
        if let url = URL(string: "https://pokemongosharetw.blogspot.com/2020/05/blog-post_27.html") {
                 UIApplication.shared.open(url)
             }
    }
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productIDs.append("remove_ad_month")
        self.productIDs.append("remove_six_month")
        self.productIDs.append("remove_ad_year")
        self.productIDs.append("richman")


        
        requestProductInfo()
        
        SKPaymentQueue.default().add(self)
        
        setUIView()
        

        // Do any additional setup after loading the view.
    }
    
    func requestProductInfo() {
        
        
        if SKPaymentQueue.canMakePayments() {
            hud = JGProgressHUD(style: .dark)
                  hud?.textLabel.text = "Loading"
                  hud?.show(in: self.view)
            // 取得所有在 iTunes Connect 所建立的內購項目
            let productIdentifiers: Set<String> = NSSet(array: self.productIDs) as! Set<String>
            let productRequest: SKProductsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
            
            productRequest.delegate = self
            productRequest.start() // 開始請求內購產品
        }
    }
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("復原購買失敗...")
        print(error.localizedDescription)
        setUIAlert(title: "復原購買失敗...", message:error.localizedDescription)
    }
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("Jack",queue.transactions.description)
        setUIAlert(title: "復原購買成功...", message: "復原購買成功")
        
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions as! [SKPaymentTransaction] {
            switch transaction.transactionState {
            case SKPaymentTransactionState.purchased:
                print("Transaction completed successfully.")
                SKPaymentQueue.default().finishTransaction(transaction)
                setUIAlert(title: "謝謝乾爹", message: "謝謝乾爹")
                print("jack",transaction.payment.productIdentifier)
//                getProductIdentifier(name: transaction.payment.productIdentifier)
                
            case SKPaymentTransactionState.failed:
                print("Transaction Failed");
                print(transaction.error?.localizedDescription);
                
                SKPaymentQueue.default().finishTransaction(transaction)
                setUIAlert(title: "Transaction Failed", message: transaction.error!.localizedDescription)
                
                
            default:
                print(transaction.transactionState.rawValue)
            }
        }
        
        func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
            if response.products.count != 0 {
                print("invalidProductIdentifiers： \(response.invalidProductIdentifiers.description)")
                for product in response.products {
                    self.productsArray.append(product)
                    productsArray.forEach { (SKProduct) in
                    }
                    
                    
                }
                
            }
            else {
                print("There are no products.")
            }
            
        }
        
}
    func setUIAlert(title :String ,message :String){
         let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         controller.addAction(okAction)
         present(controller, animated: true, completion: nil)
     }
    
    

    
    
    
    func setUIView(){
        let buymonth = UITapGestureRecognizer(target: self, action:  #selector(self.buymonth))
        self.view1.addGestureRecognizer(buymonth)
        
        let buysixmonth = UITapGestureRecognizer(target: self, action:  #selector(self.buysixmonth))
        self.view2.addGestureRecognizer(buysixmonth)
        
        let buyyear = UITapGestureRecognizer(target: self, action:  #selector(self.buyyear))
        self.view3.addGestureRecognizer(buyyear)
        
        
        let isrich = UITapGestureRecognizer(target: self, action:  #selector(self.isrich))
        self.view4.addGestureRecognizer(isrich)
  
        
    }
    @objc func buymonth(sender : UITapGestureRecognizer) {
        if SKPaymentQueue.canMakePayments() {
            // 設定交易流程觀察者，會在背景一直檢查交易的狀態，成功與否會透過 protocol 得知
            SKPaymentQueue.default().add(self)
            // 取得內購產品
            let payment = SKPayment(product: self.productsArray[0])
            // 購買消耗性、非消耗性動作將會開始在背景執行(updatedTransactions delegate 會接收到兩次)
            SKPaymentQueue.default().add(payment)
            
            
        }
        
       }
    
    @objc func buysixmonth(sender : UITapGestureRecognizer) {
        if SKPaymentQueue.canMakePayments() {
            // 設定交易流程觀察者，會在背景一直檢查交易的狀態，成功與否會透過 protocol 得知
            SKPaymentQueue.default().add(self)
            // 取得內購產品
            let payment = SKPayment(product: self.productsArray[2])
            // 購買消耗性、非消耗性動作將會開始在背景執行(updatedTransactions delegate 會接收到兩次)
            SKPaymentQueue.default().add(payment)
        }
           // Do what you want
       }
    @objc func buyyear(sender : UITapGestureRecognizer) {
        if SKPaymentQueue.canMakePayments() {
            // 設定交易流程觀察者，會在背景一直檢查交易的狀態，成功與否會透過 protocol 得知
            SKPaymentQueue.default().add(self)
            // 取得內購產品
            let payment = SKPayment(product: self.productsArray[1])
            // 購買消耗性、非消耗性動作將會開始在背景執行(updatedTransactions delegate 會接收到兩次)
            SKPaymentQueue.default().add(payment)
        }
           // Do what you want
       }
    @objc func isrich(sender : UITapGestureRecognizer) {
        if SKPaymentQueue.canMakePayments() {
            // 設定交易流程觀察者，會在背景一直檢查交易的狀態，成功與否會透過 protocol 得知
            SKPaymentQueue.default().add(self)
            // 取得內購產品
            let payment = SKPayment(product: self.productsArray[3])
            // 購買消耗性、非消耗性動作將會開始在背景執行(updatedTransactions delegate 會接收到兩次)
            SKPaymentQueue.default().add(payment)
        }
           // Do what you want
       }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    }

