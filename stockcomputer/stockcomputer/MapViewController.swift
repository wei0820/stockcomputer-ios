//
//  MapViewController.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/8.
//  Copyright © 2019 jackpan. All rights reserved.
//

import UIKit
import Mapbox
class MapViewController: UIViewController,MGLMapViewDelegate{
    let userDefaults = UserDefaults.standard
    @IBAction func nowlocation(_ sender: Any) {
        var lat  : Double = (mapview.userLocation?.coordinate.latitude)!
        var lon :Double =   (mapview.userLocation?.coordinate.longitude)!
        mapview.setCenter(CLLocationCoordinate2DMake(lat, lon), animated: false)
        mapview.zoomLevel = 15
    }
    
    @IBOutlet var mapview: MGLMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapview.setCenter(CLLocationCoordinate2DMake(25.034815, 121.564392), animated: false)
        mapview.zoomLevel = 15
        mapview.styleURL = MGLStyle.streetsStyleURL
        mapview.delegate = self
        mapview.showsUserLocation = true

        //        setRightButton(s: "加入")
    }
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        mapView.setCenter((mapView.userLocation?.coordinate)!, animated: false)
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, altitude: 4500, pitch: 15, heading: 180)
        
        // Animate the camera movement over 5 seconds.
        mapView.setCamera(camera, withDuration: 5, animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        // Into Simplified Chinese
        style.localizeLabels(into: Locale(identifier: "zh-Tw"))
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func setRightButton(s: String){
        // 導覽列右邊按鈕
        
        let rightButton = UIBarButtonItem(
            title:s,
            style:.plain,
            target:self,
            action:#selector(ViewController.setting))
        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    @objc func setting() {
        
        //            setData()
        
        
        
    }
    func setData(){
        let controller = UIAlertController(title: "加入", message: "請輸入您要推薦的營業員資料", preferredStyle: .alert)
        controller.addTextField { (textField) in
            textField.placeholder = "姓名"
            textField.keyboardType = UIKeyboardType.default
        }
        controller.addTextField { (textField) in
            textField.placeholder = "電話"
            textField.keyboardType = UIKeyboardType.phonePad
        }
        controller.addTextField { (textField) in
            textField.placeholder = "地址"
            textField.keyboardType = UIKeyboardType.default
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            let name = controller.textFields?[0].text
            let phone = controller.textFields?[1].text
            let add = controller.textFields?[2].text
            
            MapManager.AddressToLatLon(s: add!)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
}
