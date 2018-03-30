//
//  LBMerchantUploadInfoServer.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/11/20.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

protocol LBMerchantUploadInfoServer{
    // 上传资料
    func uploadMerchantData(parameters:[String:Any],success:@escaping((LBJSON)->()),failure:@escaping((String)->()))
}
extension LBMerchantUploadInfoServer where Self:LBMerchantApplyBaseViewControllerTypeThree{
 
    // 上传资料
    func uploadMerchantData(parameters:[String:Any],success:@escaping((LBJSON)->()),failure:@escaping((String)->())) {
        LBHttpService.LB_Request3(.newMerchantInsert, method: .post, parameters: parameters, headers: nil, success: { (json) in
            success(json)
        }, failure: { (failItem) in
            failure(failItem.message)
        }) { (error) in
            failure(RESPONSE_FAIL_MSG)
        }
    }
    
    func uploadMerchantData1(parameters:[String:Any],success:@escaping((LBJSON)->()),failure:@escaping((String)->())) {
        LBHttpService.LB_Request1(.merchantApply_qrmerInf_insert, method: .post, parameters: parameters, headers: nil, success: { (json) in
            success(json)
        }, failure: { (failItem) in
            failure(failItem.message)
        }) { (error) in
            failure(RESPONSE_FAIL_MSG)
        }
    }
}
