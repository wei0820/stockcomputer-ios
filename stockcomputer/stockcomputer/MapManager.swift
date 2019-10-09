//
//  MapManager.swift
//  stockcomputer
//
//  Created by oneplay on 2019/10/8.
//  Copyright © 2019 jackpan. All rights reserved.
//

import Foundation
import MapKit
class MapManager{
    static var  lat :Double = 0.0
    static var  lon :Double = 0.0
//地址轉經緯度(geocodeAddressString)
    static func AddressToLatLon(s:String) -> String {
        
    let geoCoder = CLGeocoder()
        var latlon :String
        geoCoder.geocodeAddressString((s), completionHandler: {(placemarks, error) -> Void in

            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                lat =  coordinates.latitude
               lon =  coordinates.longitude
               latlon = String(coordinates.latitude)+","+String(coordinates.longitude)
                return  ""

            }

        })
}
}
