//
//  LBUserInfoPresenter.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

protocol LBUserInfoPresenter {

    func requiredUserInfo(phoneNumber:String)
}
extension LBUserInfoPresenter where Self:LBUserInfoViewController{
    
    func requiredUserInfo(phoneNumber:String){
        LBHttpService.LB_Request(.userInfoDetail, method: .get, parameters: lb_md5Parameter(parameter: ["phoneNumber":phoneNumber]), success: {[weak self] (json) in
            guard let `self` = self else {return}
            self.cellDict = [
                        "姓名: "+json["detail"]["actnam"].stringValue,
                        "银行卡号: "+json["detail"]["actno"].stringValue,
                        "开户银行: "+json["detail"]["opnbnk"].stringValue,
                        "身份证号: "+json["detail"]["corporateidentity"].stringValue,
                        "手机号: "+json["detail"]["tel"].stringValue,
                        "推荐人: "+json["detail"]["parentName"].stringValue,
            ]
            
        }, failure: { [weak self](failItem) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(failItem.message, "确定", { (_) in
                strongSelf.navigationController?.popViewController(animated: true)
            })
        }) {[weak self] (error) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", nil)
        }
        
    }
}
