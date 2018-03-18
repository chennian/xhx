//
//  LBWXBindPhonePresenter.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

protocol LBWXBindPhonePresenter {
    func bindPhoneRquire(parameter:[String:Any])
}
extension LBWXBindPhonePresenter where Self:LBBindPhoneViewController{
    func bindPhoneRquire(parameter:[String:Any]){
        LBHttpService.LB_Request(.bindWeixinMobile, method: .get, parameters: lb_md5Parameter(parameter: parameter), success: { [weak self](json) in
            guard let strongSelf = self else {return}
            strongSelf.showAlertView(json["RSPMSG"].stringValue, "确定", { (_) in
                
            })
            
        },failure: {[weak self] (item ) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(message:item.message, actionTitles: ["取消","确定"], handler:{ (action) in
                if(action.title == "取消"){
                    strongSelf.navigationController?.popViewController(animated: true)
                }
            })
        
        }){ [weak self](error) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", { (_) in
                
            })
            
        }
    }
}
