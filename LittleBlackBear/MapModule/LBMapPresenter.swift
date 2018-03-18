//
//  LBMapPresenter.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/25.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

func locationCoordinateConvert()->CLLocationCoordinate2D{
 
    if LBKeychain.get(latitudeKey) == "" || LBKeychain.get(longiduteKey) == ""{
        return CLLocationCoordinate2DMake(0, 0)

    }
    let coor  = CLLocationCoordinate2DMake(Double(LBKeychain.get(latitudeKey))!, Double(LBKeychain.get(longiduteKey) )!)
    let dic:[AnyHashable : Any] = (BMKConvertBaiduCoorFrom(coor, BMK_COORDTYPE_COMMON))!
    return BMKCoorDictionaryDecode(dic )
}
protocol LBMapPresenter {
    // 商家位置
    func requiredMapData(mercNum:String,location:String,success:@escaping((LBMapModel<mapDetailModel>)->Void))
    // 红包位置
    func requestAllRedPacket(mercNum:String,success:@escaping((redPacketModel)->Void))
    // 打开红包
    func openRedPacketAction(mercNum:String,redPacketId:String,success:@escaping((Float)->()),fail:@escaping((String)->()))
}
extension LBMapPresenter where Self:LBMapViewController{
    
    func requiredMapData(mercNum:String,location:String,success:@escaping((LBMapModel<mapDetailModel>)->Void)){ // location = 经度+ , +纬度   //radius default 10KM
        let parameter = ["mercNum":mercNum,"radius":"10000","pageSize":"30","location":location]
        LBHttpService.LB_Request(.searchLsbCloudMer, method: .post, parameters: parameter, headers: nil, success: { (json) in
            success(LBMapModel<mapDetailModel>(json: json))
        }, failure:{ itme in
            Print(itme)
        }){ error in
            Print(error)
        }
    }
    
    func requestAllRedPacket(mercNum:String,success:@escaping((redPacketModel)->Void)) {
        let parameter = lb_md5Parameter(parameter: ["mercnum":mercNum])
        LBHttpService.LB_Request(.httpGetAllRedPacket, method: .get, parameters:parameter , headers: nil, success: { (json) in
            success(redPacketModel(json:json))
            Print(json)
        }, failure: { (faileItem) in
            Print(faileItem)
        }) { (err) in
            Print(err)
        }

    }
    
    func openRedPacketAction(mercNum:String,redPacketId:String,success:@escaping((Float)->()),fail:@escaping((String)->())){
        let parameter = lb_md5Parameter(parameter: ["mercnum":mercNum,"redPacketId":redPacketId])
        LBHttpService.LB_Request(.openRedPacket, method: .get, parameters: parameter, headers: nil, success: { (json) in
            success(json["detail"]["redAmount"].floatValue)
        }, failure: { (failItem) in
            fail(failItem.message)
        }) { (error) in
            
        }
        
    }
}
















