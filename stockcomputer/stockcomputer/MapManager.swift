//
//  MapManager.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/8.
//  Copyright © 2019 jackpan. All rights reserved.
//

import Foundation
import MapKit
import Toaster

class MapManager{
    
    //地址轉經緯度(geocodeAddressString)
    static func AddressToLatLon(s:String){
        let geoCoder = CLGeocoder()
        var  lat :Double = 0.0
        var  lon :Double = 0.0
        geoCoder.geocodeAddressString((s), completionHandler: {(placemarks, error) -> Void in
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                lat =  coordinates.latitude
                lon =  coordinates.longitude
                Toast(text:  String(coordinates.latitude)+","+String( coordinates.longitude)).show()

                
            }
            
        }
            
        )    }
    

}
