//
//  LBSettingPresenter.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/5.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

protocol LBSettingPresenter {
    func query_isSetPayPassword(completionHandler:@escaping(()->()))

}
extension LBSettingPresenter{
    func query_isSetPayPassword(completionHandler:@escaping(()->())){
        let mercId = LBKeychain.get(CURRENT_MERC_ID)
        LBHttpService.LB_Request(.isSetPayPassword, method: .get, parameters: lb_md5Parameter(parameter: ["mercNum":mercId]), success: { (_) in
            completionHandler()
        }, failure: { (failItem) in
          
        }) { (error) in
            
        }
    }
}
