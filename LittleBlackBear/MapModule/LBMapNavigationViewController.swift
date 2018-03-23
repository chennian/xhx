//
//  LBMapNavigationViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBMapNavigationViewController: UIViewController {

    var endLongitude:Double = 0.00
    var endLatitude:Double = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIApplication.shared.canOpenURL(URL(string:"baidumap://")!) {
            appNavigation()
        }else{
            webNavigation()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    

}
extension LBMapNavigationViewController{
    
    func appNavigation() {

        let parameter = BMKNaviPara()
        parameter.isSupportWeb = true
        let end = BMKPlanNode()
        guard endLatitude > 0.00,endLongitude > 0.00 else {return}
        let coordinate = CLLocationCoordinate2DMake(endLatitude, endLongitude)
        end.pt = coordinate

        parameter.endPoint = end
        parameter.appScheme = "baidumapsdk://mapsdk.baidu.com"
        BMKNavigation.openBaiduMapNavigation(parameter)
        
    }
  
    func webNavigation() {
        SZLocationManager.shareUserInfonManager.startUpLocation()
        let latitude = LBKeychain.get(latitudeKey)
        let logintude = LBKeychain.get(longiduteKey)
        let parameter = BMKNaviPara()
        parameter.isSupportWeb = true
        
        let start = BMKPlanNode()

        guard latitude.count > 0,logintude.count > 0 else {return}
        guard endLatitude > 0.00,endLongitude > 0.00 else {return}

        var coordinate = CLLocationCoordinate2DMake(Double(latitude)!, Double(logintude)!)
        start.pt = coordinate

        parameter.startPoint = start
        
        let end = BMKPlanNode()
         coordinate = CLLocationCoordinate2DMake(endLatitude, endLongitude)
        end.pt = coordinate
        parameter.endPoint = end
        
        parameter.appName = "小黑熊"
        BMKNavigation.openBaiduMapNavigation(parameter)
    }
}




