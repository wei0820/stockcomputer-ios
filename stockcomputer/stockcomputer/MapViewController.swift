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
        mapview.setCenter((mapview.userLocation?.coordinate)!, animated: false)
               var lat  : Double = mapview.userLocation?.coordinate.latitude ?? 0.0
               var lon :Double =   mapview.userLocation?.coordinate.longitude ?? 0.0

               mapview.setCenter(CLLocationCoordinate2DMake(lat, lon), animated: false)
                    mapview.zoomLevel = 15
    }
    
    @IBOutlet var mapview: MGLMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.setCenter(CLLocationCoordinate2DMake(mapview.latitude, mapview.longitude), animated: false)
             mapview.zoomLevel = 15
        mapview.styleURL = MGLStyle.streetsStyleURL
        mapview.delegate = self
             
             // Allow the map view to display the user's location
             mapview.showsUserLocation = true
        // Do any additional setup after loading the view.
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
           style.localizeLabels(into: nil)
           // Into Simplified Chinese
           style.localizeLabels(into: Locale(identifier: "zh-Tw"))
           // Into the local language where a given feature is located
           style.localizeLabels(into: Locale(identifier: "mul"))
     
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
            
            if((userDefaults.value(forKey: "isAnonymous")) != nil){
                let controller = UIAlertController(title: "訪客身份", message: "請先登入在使用！", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                controller.addAction(okAction)
                present(controller, animated: true, completion: nil)
                return
                
            }
    //        let loginManager = LoginManager()
    //        loginManager.logOut()
            
            let stroyboard = UIStoryboard(name: "Main", bundle: nil);
            let HomeVc = stroyboard.instantiateViewController(withIdentifier: "member")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate;
            appDelegate.window?.rootViewController = HomeVc
            
        }
}
