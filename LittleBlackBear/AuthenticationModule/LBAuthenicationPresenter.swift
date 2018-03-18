//
//  LBAuthenicationPresenter.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/1/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

protocol LBAuthenicationPresenter{
  func uploadAuthenicationData(parameter:[String:Any])

}
extension LBAuthenicationPresenter where Self:LBAuthenicationViewController{
    func uploadAuthenicationData(parameter:[String:Any]){
        LBHttpService.LB_Request(.userFastAuth, method: .post, parameters: lb_md5Parameter(parameter: parameter), success: { [weak self] (item) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(item["RSPMSG"].stringValue, "确定",{ (_) in
                guard let action = strongSelf.authenicationSuccessHandler else {return }
                LBKeychain.set("0", key: ISATHUENICATION)
                action()
                strongSelf.navigationController?.popViewController(animated: true)
			})
        }, failure: {[weak self] (item) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(item.message, "确定", { (_) in
                
			} )
        }) {[weak self] (error) in
            guard let strongSelf = self else{return}
            strongSelf.showAlertView(RESPONSE_FAIL_MSG, "确定", { (_) in
			})
        }
    }
}
