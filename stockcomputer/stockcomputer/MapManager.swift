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
    func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
           //1
           let locale = Locale(identifier: "zh_TW")
           let loc: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
           if #available(iOS 11.0, *) {
               CLGeocoder().reverseGeocodeLocation(loc, preferredLocale: locale) { placemarks, error in
               guard let placemark = placemarks?.first, error == nil else {
                   UserDefaults.standard.removeObject(forKey: "AppleLanguages")
                   completion(nil, error)
                   return
               }
               completion(placemark, nil)
           }
       }
}
}
