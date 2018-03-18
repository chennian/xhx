//
//  LBConprenster.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/11.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

protocol LBCouponrenster  {
    func getCouponRequire(markId:String,mercId:String,completionHandler:@escaping((Bool,String)->()))
}
extension LBCouponrenster{
    
    func getCouponRequire(markId:String,mercId:String,completionHandler:@escaping((Bool,String)->())){
        let parameters:[String:Any] = lb_md5Parameter(parameter: ["markId":markId,"mercId":mercId])
        LBHttpService.LB_Request(.userGetMerMark, method: .post, parameters:parameters, success: { (json) in
            completionHandler(true,"")
        }, failure: { (failItem) in
            completionHandler(false,failItem.message)

        }) { (error) in
            completionHandler(false,error.localizedDescription)

        }
    }
}
