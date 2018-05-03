//
//  LBMapNavigationTool.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
import MapKit
enum LBMapNavigationType:String{

    case apple = "苹果地图"
    case amap = "高度地图"
    case baidu = "百度地图"
}

final class LBMapNavigationManger {
    
    fileprivate static let shareIntance = LBMapNavigationManger()
    class var manger:LBMapNavigationManger{
        return shareIntance
    }
    
    func navigationActionWithCoordinate(coordinate:CLLocationCoordinate2D,
                                        type:String,
                                        name:String? = nil) {
        guard let type = LBMapNavigationType(rawValue: type) else{return}
        switch type {
        case .amap:
            openAMap(coordinate: coordinate, name: name)
        case .apple:
            openAppleMap(coordinate: coordinate,name: name)
        case .baidu:
            openBMKMap(coordinate: coordinate,name: name)
        }
        
    }
	

    func openAMap(coordinate:CLLocationCoordinate2D,
                                        name:String? = nil){

		if UIApplication.shared.canOpenURL(URL(string:"iosamap://")!) {
			
			let url:String = "iosamap://navi?sourceApplication=\(APPNAME)&backScheme=myapp&did=BGVIS2&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&dev=1&style=2".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
			if #available(iOS 10.0, *){
				UIApplication.shared.open(URL(string:url)!, options: [:], completionHandler: { (result) in
					Print(result)
				})
			}else{
				UIApplication.shared.openURL(URL(string:url)!)

			}

        }else{
            UIAlertView(title: nil, message: "您未安装高德地图请选择其他导航方式", delegate: nil, cancelButtonTitle: "确定").show()
            
        }
        
    }
    
    func openAppleMap(coordinate:CLLocationCoordinate2D,
                      name:String? = nil) {
        let startItem:MKMapItem = MKMapItem.forCurrentLocation()
        let placeMark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        
        let endItem:MKMapItem = MKMapItem(placemark: placeMark)
        if name != nil,name!.count > 0{
            endItem.name = name
        }
		let launchOptions:[String:Any] = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving ,
												MKLaunchOptionsShowsTrafficKey:true,
												MKLaunchOptionsMapTypeKey:MKMapType.standard.rawValue]
        MKMapItem.openMaps(with: [startItem,endItem],
						   launchOptions:launchOptions )
        
    }
    
    func openBMKMap(coordinate:CLLocationCoordinate2D,
                      name:String? = nil) {
        
		let parameter = BMKNaviPara()
		parameter.isSupportWeb = true
		let end = BMKPlanNode()
		end.pt = coordinate
		parameter.endPoint = end
        parameter.startPoint = end
		parameter.appScheme = "baidumapsdk://mapsdk.baidu.com"
		BMKNavigation.openBaiduMapNavigation(parameter)
		
    }

    
    
}

