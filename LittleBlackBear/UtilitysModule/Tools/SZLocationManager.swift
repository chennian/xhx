//
//  SZLocationManager.swift
//  BaiXiangPay
//
//  Created by 蘇崢 on 16/12/23.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
class SZLocationManager:NSObject{
	
	fileprivate static let sharedInstance = SZLocationManager()
	
	fileprivate lazy var locationManager:CLLocationManager = {
		let locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.distanceFilter = 1000.0
//        locationManager.startUpdatingLocation()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		return locationManager
	}()
    
    
    var getLoaction : Variable<(CLLocationDegrees,CLLocationDegrees)> =  Variable((0.00,0.00))
    
	func startUpLocation(){
     
        locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
	}
	class var shareUserInfonManager:SZLocationManager{
		return sharedInstance
	}
	
	fileprivate override init() {
		
	}
	
}
extension SZLocationManager:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        ZJLog(messagr: error)
    }
	
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
        locationManager.stopUpdatingLocation()
		let location = locations.first
		let coordinate:CLLocationCoordinate2D = (location?.coordinate)!
		let longidute = coordinate.longitude
        
		let latitude  = coordinate.latitude
        
        
		LBKeychain.set("\(longidute)", key: longiduteKey)
		LBKeychain.set("\(latitude)", key: latitudeKey)
        
        
//        Print(latitude)
//        Print(longidute)
		let geocoder:CLGeocoder = CLGeocoder()
		geocoder.reverseGeocodeLocation((location)!) { (placemar, error) ->Void in
			if error != nil{
				Print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
			}
			guard ((placemar?.count) != nil) else {return}
			let placemark:CLPlacemark = (placemar?.first)!
			var city = placemark.locality
            LBKeychain.set(city!, key:"CITY")

            let subLocality = placemark.subLocality
			let are  = placemark.thoroughfare
			if city == nil {
				city = placemark.administrativeArea
			}
            if city?.isChinese() == false  {
                city = "深圳"
                LBKeychain.set("\(114.047870066526)", key: longiduteKey)
                LBKeychain.set("\(22.6008299566074)", key: latitudeKey)
            }
            
            
            LBKeychain.set(city!, key: LOCATION_CITY_KEY)
			Print("\(String(describing: city))-\(String(describing: are))")
			guard are != nil  else {return}
			LBKeychain.set(are!, key: locationAareKey)
            guard subLocality != nil else {return}
            LBKeychain.set(subLocality!, key: locationSubLocalKey)

            self.getLoaction.value = (latitude,longidute)
		}
		
	}
}

